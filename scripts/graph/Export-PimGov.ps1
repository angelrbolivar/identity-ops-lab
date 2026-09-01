# Export-PimGov.ps1
# HOME only. Interactive admin. Run the same night PIM / packages / reviews are built.
# Scopes: RoleManagement.Read.Directory PrivilegedAccess.Read.AzureAD EntitlementManagement.Read.All AccessReview.Read.All
#
# Writes:
#   evidence/graph-exports/YYYYMMDD-pim-entra.json
#   evidence/graph-exports/YYYYMMDD-pim-groups.json
#   evidence/graph-exports/YYYYMMDD-access-packages.json
#   evidence/graph-exports/YYYYMMDD-access-reviews.json

#Requires -Modules Microsoft.Graph.Authentication, Microsoft.Graph.Identity.Governance

$ErrorActionPreference = 'Stop'
$stamp = Get-Date -Format 'yyyyMMdd'
$outDir = Join-Path $PSScriptRoot '..\..\evidence\graph-exports'
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

Connect-MgGraph -NoWelcome -Scopes @(
    'RoleManagement.Read.Directory',
    'PrivilegedAccess.Read.AzureAD',
    'EntitlementManagement.Read.All',
    'AccessReview.Read.All'
)

$pimEntra = [ordered]@{
    Eligible = @(Get-MgRoleManagementDirectoryRoleEligibilitySchedule -All -ErrorAction SilentlyContinue)
    EligibleInstances = @(Get-MgRoleManagementDirectoryRoleEligibilityScheduleInstance -All -ErrorAction SilentlyContinue)
    Active = @(Get-MgRoleManagementDirectoryRoleAssignmentSchedule -All -ErrorAction SilentlyContinue)
    ActiveInstances = @(Get-MgRoleManagementDirectoryRoleAssignmentScheduleInstance -All -ErrorAction SilentlyContinue)
}
$pimEntra | ConvertTo-Json -Depth 12 | Set-Content -Encoding utf8 (Join-Path $outDir "$stamp-pim-entra.json")

$pimGroups = [ordered]@{
    Eligible = @(Get-MgIdentityGovernancePrivilegedAccessGroupEligibilitySchedule -All -ErrorAction SilentlyContinue)
    EligibleInstances = @(Get-MgIdentityGovernancePrivilegedAccessGroupEligibilityScheduleInstance -All -ErrorAction SilentlyContinue)
    Active = @(Get-MgIdentityGovernancePrivilegedAccessGroupAssignmentSchedule -All -ErrorAction SilentlyContinue)
    ActiveInstances = @(Get-MgIdentityGovernancePrivilegedAccessGroupAssignmentScheduleInstance -All -ErrorAction SilentlyContinue)
}
$pimGroups | ConvertTo-Json -Depth 12 | Set-Content -Encoding utf8 (Join-Path $outDir "$stamp-pim-groups.json")

$packages = [ordered]@{
    Catalogs = @(Get-MgEntitlementManagementCatalog -All -ErrorAction SilentlyContinue)
    AccessPackages = @(Get-MgEntitlementManagementAccessPackage -All -ErrorAction SilentlyContinue)
    Assignments = @(Get-MgEntitlementManagementAssignment -All -ErrorAction SilentlyContinue)
}
$packages | ConvertTo-Json -Depth 12 | Set-Content -Encoding utf8 (Join-Path $outDir "$stamp-access-packages.json")

$reviews = @(Get-MgIdentityGovernanceAccessReviewDefinition -All -ErrorAction SilentlyContinue)
$reviews | ConvertTo-Json -Depth 12 | Set-Content -Encoding utf8 (Join-Path $outDir "$stamp-access-reviews.json")

Write-Host "Wrote $outDir\$stamp-pim-entra.json and siblings"
Disconnect-MgGraph | Out-Null
