# Export-SignInAudit.ps1
# HOME only. Optional. Skip if this cmdlet 403s. Do not debug for an hour.
# Scopes: AuditLog.Read.All Directory.Read.All
#
# Writes:
#   evidence/graph-exports/YYYYMMDD-signins.json
#   evidence/graph-exports/YYYYMMDD-audit.json

#Requires -Modules Microsoft.Graph.Authentication, Microsoft.Graph.Reports

$ErrorActionPreference = 'Stop'
$stamp = Get-Date -Format 'yyyyMMdd'
$outDir = Join-Path $PSScriptRoot '..\..\evidence\graph-exports'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

Connect-MgGraph -NoWelcome -Scopes @(
    'AuditLog.Read.All',
    'Directory.Read.All'
)

try {
    $signins = Get-MgAuditLogSignIn -Top 50
    $signins | ConvertTo-Json -Depth 10 | Set-Content -Encoding utf8 (Join-Path $outDir "$stamp-signins.json")
} catch {
    Write-Warning "Sign-in export failed. Leave it. $($_.Exception.Message)"
}

try {
    $audit = Get-MgAuditLogDirectoryAudit -Top 50
    $audit | ConvertTo-Json -Depth 10 | Set-Content -Encoding utf8 (Join-Path $outDir "$stamp-audit.json")
} catch {
    Write-Warning "Audit export failed. Leave it. $($_.Exception.Message)"
}

Write-Host "Optional dump done for $stamp"
Disconnect-MgGraph | Out-Null
