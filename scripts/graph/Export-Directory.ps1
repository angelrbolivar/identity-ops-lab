# Export-Directory.ps1
# HOME only. Interactive admin.
# Scopes: User.Read.All Group.Read.All Directory.Read.All Policy.Read.All RoleManagement.Read.Directory
#
# Writes:
#   evidence/graph-exports/YYYYMMDD-users.json
#   evidence/graph-exports/YYYYMMDD-groups.json
#   evidence/graph-exports/YYYYMMDD-directory-roles.json
#   evidence/graph-exports/YYYYMMDD-ca-policies.json

#Requires -Modules Microsoft.Graph.Authentication, Microsoft.Graph.Users, Microsoft.Graph.Groups, Microsoft.Graph.Identity.DirectoryManagement, Microsoft.Graph.Identity.SignIns

$ErrorActionPreference = 'Stop'
$stamp = Get-Date -Format 'yyyyMMdd'
$outDir = Join-Path $PSScriptRoot '..\..\evidence\graph-exports'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

Connect-MgGraph -NoWelcome -Scopes @(
    'User.Read.All',
    'Group.Read.All',
    'Directory.Read.All',
    'Policy.Read.All',
    'RoleManagement.Read.Directory'
)

$users = Get-MgUser -All -Property Id, DisplayName, UserPrincipalName, AccountEnabled, UserType, CreatedDateTime
$users | Select-Object Id, DisplayName, UserPrincipalName, AccountEnabled, UserType, CreatedDateTime |
    ConvertTo-Json -Depth 5 |
    Set-Content -Encoding utf8 (Join-Path $outDir "$stamp-users.json")

$groups = Get-MgGroup -All -Property Id, DisplayName, SecurityEnabled, MailEnabled, GroupTypes, IsAssignableToRole, MembershipRule
$groupExport = foreach ($g in $groups) {
    $members = Get-MgGroupMember -GroupId $g.Id -All -ErrorAction SilentlyContinue
    [pscustomobject]@{
        Id                  = $g.Id
        DisplayName         = $g.DisplayName
        SecurityEnabled     = $g.SecurityEnabled
        IsAssignableToRole  = $g.IsAssignableToRole
        GroupTypes          = $g.GroupTypes
        Members             = @($members | ForEach-Object { $_.Id })
    }
}
$groupExport | ConvertTo-Json -Depth 6 | Set-Content -Encoding utf8 (Join-Path $outDir "$stamp-groups.json")

$roles = Get-MgDirectoryRole -All
$roleExport = foreach ($r in $roles) {
    $members = Get-MgDirectoryRoleMember -DirectoryRoleId $r.Id -All -ErrorAction SilentlyContinue
    [pscustomobject]@{
        Id          = $r.Id
        DisplayName = $r.DisplayName
        RoleTemplateId = $r.RoleTemplateId
        Members     = @($members | ForEach-Object {
            [pscustomobject]@{ Id = $_.Id }
        })
    }
}
$roleExport | ConvertTo-Json -Depth 6 | Set-Content -Encoding utf8 (Join-Path $outDir "$stamp-directory-roles.json")

$ca = Get-MgIdentityConditionalAccessPolicy -All
$ca | ConvertTo-Json -Depth 12 | Set-Content -Encoding utf8 (Join-Path $outDir "$stamp-ca-policies.json")

Write-Host "Wrote $outDir\$stamp-*.json"
Disconnect-MgGraph | Out-Null
