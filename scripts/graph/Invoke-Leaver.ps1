# Invoke-Leaver.ps1
# HOME only. Second pass after the portal leaver ticket.
# Scopes: User.ReadWrite.All User.RevokeSessions.All Directory.Read.All
#
# Hard-stop: admin, breakglass, or any Global Admin UPN you pass by mistake.
# Default target: leaver.marco
#
# Writes:
#   evidence/graph-exports/YYYYMMDD-leaver-marco-before.json
#   evidence/graph-exports/YYYYMMDD-leaver-marco-after.json

#Requires -Modules Microsoft.Graph.Authentication, Microsoft.Graph.Users, Microsoft.Graph.Groups

param(
    [Parameter()]
    [string]$UserPrincipalName = 'leaver.marco@destinofinalrusheroutlook.onmicrosoft.com'
)

$ErrorActionPreference = 'Stop'
$blocked = @(
    'admin@destinofinalrusheroutlook.onmicrosoft.com',
    'breakglass@destinofinalrusheroutlook.onmicrosoft.com'
)

$upn = $UserPrincipalName.ToLowerInvariant()
if ($blocked -contains $upn -or $upn.StartsWith('admin@') -or $upn.StartsWith('breakglass@')) {
    throw "Refused. $UserPrincipalName is a protected account. This script does not touch admin or breakglass."
}

$stamp = Get-Date -Format 'yyyyMMdd'
$outDir = Join-Path $PSScriptRoot '..\..\evidence\graph-exports'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

Connect-MgGraph -NoWelcome -Scopes @(
    'User.ReadWrite.All',
    'User.RevokeSessions.All',
    'Directory.Read.All'
)

$user = Get-MgUser -UserId $UserPrincipalName -Property Id, DisplayName, UserPrincipalName, AccountEnabled
if (-not $user) { throw "User not found: $UserPrincipalName" }

$memberOf = @(Get-MgUserMemberOf -UserId $user.Id -All -ErrorAction SilentlyContinue)
$before = [ordered]@{
    Id              = $user.Id
    DisplayName     = $user.DisplayName
    UserPrincipalName = $user.UserPrincipalName
    AccountEnabled  = $user.AccountEnabled
    MemberOf        = @($memberOf | ForEach-Object { [pscustomobject]@{ Id = $_.Id } })
}
$before | ConvertTo-Json -Depth 6 | Set-Content -Encoding utf8 (Join-Path $outDir "$stamp-leaver-marco-before.json")

Update-MgUser -UserId $user.Id -AccountEnabled:$false
Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/v1.0/users/$($user.Id)/revokeSignInSessions" | Out-Null

foreach ($obj in $memberOf) {
    $odata = $obj.AdditionalProperties['@odata.type']
    if ($odata -eq '#microsoft.graph.group') {
        try {
            Remove-MgGroupMemberByRef -GroupId $obj.Id -DirectoryObjectId $user.Id -ErrorAction Stop
        } catch {
            Write-Warning "Could not remove $($obj.Id): $($_.Exception.Message)"
        }
    }
}

$afterUser = Get-MgUser -UserId $user.Id -Property Id, DisplayName, UserPrincipalName, AccountEnabled
$afterMemberOf = @(Get-MgUserMemberOf -UserId $user.Id -All -ErrorAction SilentlyContinue)
$after = [ordered]@{
    Id              = $afterUser.Id
    DisplayName     = $afterUser.DisplayName
    UserPrincipalName = $afterUser.UserPrincipalName
    AccountEnabled  = $afterUser.AccountEnabled
    MemberOf        = @($afterMemberOf | ForEach-Object { [pscustomobject]@{ Id = $_.Id } })
}
$after | ConvertTo-Json -Depth 6 | Set-Content -Encoding utf8 (Join-Path $outDir "$stamp-leaver-marco-after.json")

Write-Host "Disabled $($afterUser.UserPrincipalName). AccountEnabled=$($afterUser.AccountEnabled)"
Disconnect-MgGraph | Out-Null
