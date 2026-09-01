# 01 — Identities

1 Sep 2026. Norte Club. Microsoft Entra ID P2 trial.

This is a lab directory, not production Entra.

## Accounts

`admin` is the Global Admin I sign into to build this tenant. It is the account I use all day, which is exactly why it is not an emergency account.

`breakglass` is the second Global Admin. I do not use it. It exists for the day `admin` is locked out, broken by a policy I wrote, or phished. It is the only standing emergency GA and the only Conditional Access exclusion.

No other account holds a standing directory role.

| Account | Standing role | Notes |
|---|---|---|
| `admin` | Global Admin | Daily. Inside CA. |
| `breakglass` | Global Admin | Unused. Only CA exclude. |
| `pim.admin` | none | Eligible Authentication Administrator. NC-005. |
| `helpdesk.t1` | none | Eligible Member of `GRP-RA-Helpdesk` only. NC-006. |
| `user.standard` | none | Hire-bar sign-in and MFA wipe. NC-001, NC-003. |
| `joiner.sofia` | none | TAP then Authenticator. Methods wiped under PIM. NC-004, NC-015. |
| `ops.luis` | none | `GRP-Ops`. |
| `finance.ana` | none | `GRP-Finance`. |
| `mover.diego` | none | Moved Ops → Finance. NC-013. |
| `leaver.marco` | none | Disabled 31 Aug 2026. Groups empty. NC-012. |
| `Vendor Guest` | none | B2B. No group. NC-014. |

Rusher Ink is leftover from trial signup. Not a lab user. No group. No role I assigned. Crop it.

Current directory list: [NC-011](evidence/tickets/NC-011-directory-fill.md). Guest: [NC-014](evidence/tickets/NC-014-guest-vendor.md).

## Groups

`GRP-Ops`, `GRP-Finance`, `GRP-IT`. Security, Assigned, not role-assignable.

- `GRP-Ops` — Luis Ops. Assignment required target for `nc-timeclock`.
- `GRP-Finance` — Ana Finance, Diego Mover. Review target `AR-Finance-Q`.
- `GRP-IT` — empty.

`GRP-SSPR-Enabled` — security, Assigned, not role-assignable. Member: `user.standard` only. SSPR is not All users. NC-002.

`GRP-RA-Helpdesk` — role-assignable. Authentication Administrator is Active on the group. Zero standing members. `helpdesk.t1` is Eligible Member via PIM for Groups. No directory-role Eligible assignment on the group. NC-006.

## Why helpdesk.t1 is not a standing Global Admin

Tier 1 is the account that gets hit first. It takes requests from strangers all day and its whole job is to be helpful. Standing Global Admin on that account means a successful phish does not get a helpdesk mailbox, it gets the tenant.

Same idea I worked with at Remitly: do not leave the powerful action sitting on the account that gets hit first. Elevation is PIM for Groups, one hour, `admin` approves. When the clock ends the member list is empty again.

## Scope

Built on this P2 trial: users, groups, CA-01 through CA-06, SSPR, TAP, PIM for Entra roles, PIM for Groups, Identity Protection blades left Disabled, one enterprise app, consent lock, one catalog / ToU / access package, one access review, one B2B guest, JML as tickets.

Not built: Administrative Units, custom roles, Lifecycle Workflows, Entra Connect, Intune, Okta, Sentinel on this tenant. Graph dump is HOME and is not in the repo yet.
