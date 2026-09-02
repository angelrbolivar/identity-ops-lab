# Decisions

Only decisions that are already true in the tenant. No planned work.

## admin stays in Conditional Access

28 Aug 2026.

`admin` is the account I sign into all day. Excluding it makes MFA theater. CA-01 through CA-06 include it.

## breakglass is the only CA exclude and the only standing emergency GA

28 Aug 2026.

`admin` can be locked out by a policy I wrote, a dead Authenticator, or a phish. `breakglass` exists for that day. I do not use it to build the lab.

## helpdesk.t1 has no standing directory role

28 Aug 2026.

Tier-1 takes requests from strangers. Standing privilege on that account is the blast radius I will not sign up for. PIM for Groups is the elevate path. Built 31 Aug 2026. NC-006.

## PIM is eligible plus a clock

28 Aug 2026.

`pim.admin` is eligible Authentication Administrator. Activation is 1 hour, MFA on activate, approval by `admin` only. Permanent active assignments are off on that role. NC-005 activated and deactivated. NC-015 used the same role to wipe `joiner.sofia`, then dropped it. No standing Auth Admin on the user.

## T1 elevates through a role-assignable group

31 Aug 2026.

`GRP-RA-Helpdesk` is role-assignable. Authentication Administrator is Active on the group. `helpdesk.t1` is Eligible Member only. Activation 1 hour, approval by `admin`. Zero standing members. No directory-role Eligible assignment on the group. NC-006.

## SSPR is a group, not All

28 Aug 2026.

`GRP-SSPR-Enabled` only. Member `user.standard`. I do not turn SSPR on for every cloud user in a gym tenant I just built. NC-002.

## Risk lives in Conditional Access, not the retiring IDP policy blades

31 Aug 2026.

ID Protection User risk and Sign-in risk policies are read-only and retire 1 Oct 2026. Both were Disabled. I left them Disabled. Live wiring is CA-04 Block High sign-in risk, CA-05 MFA Medium sign-in risk, CA-06 password change Medium+ user risk. Risk detections empty. I did not fake a risky sign-in. NC-007.

## Assignment required before user consent

31 Aug 2026.

`nc-timeclock` is assignment required. Assigned to `GRP-Ops`. User consent is disabled for the tenant. A user not in Ops cannot add the app. NC-008.

## Entitlement is thin and dies with P2

1 Sep 2026.

One catalog `Norte Club`. One ToU. One package `AP-Ops-Access` grants `GRP-Ops` Member. Self request + `admin` approval. 30-day expiry. Separate one-time review `AR-Finance-Q` on `GRP-Finance`, reviewer `admin`, auto-apply off. No Lifecycle Workflows. NC-009, NC-010.

## JML is tickets, not workflows

1 Sep 2026.

Joiner is TAP. Mover is two group clicks. Leaver is disable + revoke sessions + empty groups. Guest is invite only, no group, no role. NC-004, NC-011, NC-012, NC-013, NC-014.

## Privileged change needs a ticket

28 Aug 2026.

Requester, verification, before, after, rollback. NC-001 through NC-015.

## Graph is HOME evidence, not the control plane

1 Sep 2026.

Portal built the tenant. Graph dumped it. Twelve JSON files in `evidence/graph-exports/` dated 20260901. Scripts do not create users. `Invoke-Leaver.ps1` refuses `admin` and `breakglass`. Leaver second pass disabled `leaver.marco` and revoked sessions via Graph REST.
