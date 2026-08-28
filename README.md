# Norte Club — Entra identity lab

Norte Club is a fictional gym and payments company. I built its Entra tenant from scratch so I could do identity work end to end instead of reading about it. Angel Rodriguez Bolivar.

Microsoft Entra ID P2 trial. Started 27 Aug 2026. The trial ends around 23 Sep 2026 and the tenant goes with it. Screenshots and tickets are the evidence.

## What I do in production

At ABC Fitness I verify the requester's identity first, then change their access in Ignite. Password resets are gated to L3, so I route those instead of doing them.

At Remitly I triaged ATO and fraud alerts in a live queue under SLA: release, hold, or block, on incomplete information.

CompTIA Security+. Detection work lives in [angelrbolivar-soc-portfolio](https://github.com/angelrbolivar/angelrbolivar-soc-portfolio).

I do not administer Entra, Okta, AD, or M365 at work. That is the gap this lab is closing.

## Rules

- `admin` is the daily Global Admin. It stays inside Conditional Access. I do not exclude the account I work in.
- `breakglass` is the only standing emergency Global Admin and the only CA exclusion. I do not use it.
- `helpdesk.t1` holds no standing directory role. Tier-1 is not a privilege path.
- Privileged changes get a ticket: requester, verification, before, after, rollback.

## What exists now

28 Aug 2026.

- Directory and groups: [01-identities.md](01-identities.md)
- CA-01 / CA-02 / CA-03 On, Security defaults off: [02-conditional-access.md](02-conditional-access.md)
- Live sign-in for `user.standard`, CA-01 Success on the log row, not What If: [evidence/tickets/NC-001-live-signin-user-standard.md](evidence/tickets/NC-001-live-signin-user-standard.md)
- Identity Secure Score baseline: 53.33% on 28 Aug 2026

## Users and groups

![Norte Club users](screenshots/01-users.png)

`admin` — daily Global Admin, in CA.
`breakglass` — standing Global Admin, unused, excluded from CA.
`helpdesk.t1`, `pim.admin`, `user.standard`, `leaver.marco` — no standing directory role.

Groups: `GRP-Ops`, `GRP-Finance`, `GRP-IT`. Security, assigned, empty, not role-assignable.

Leftover personal account from trial signup is cropped and unused.

## Conditional Access

![CA-01 On](screenshots/05-ca-mfa-all.png)

Three policies, all On. `breakglass` excluded from each. `admin` is not.

- **CA-01-MFA-All-Users** — Require MFA
- **CA-02-Block-Legacy-Auth** — Block Exchange ActiveSync and Other clients
- **CA-03-MFA-Admins** — Require MFA for privileged roles

What If was the first pass. The hire-bar proof is a live row:

28 Aug 2026 12:58:50 PM. `user.standard`. Azure Portal. Success.

| Policy | Result |
|---|---|
| CA-01-MFA-All-Users | Success |
| CA-02-Block-Legacy-Auth | Not Applied |
| CA-03-MFA-Admins | Not Applied |

![Live sign-in list](evidence/screenshots/12-user-standard-signin-live.png)

![CA tab on that row](evidence/screenshots/13-user-standard-signin-ca01.png)

Same-day Interrupted and Failure rows stay in the list shot. I did not crop them.

## Tickets

| ID | Action |
|---|---|
| [NC-001](evidence/tickets/NC-001-live-signin-user-standard.md) | Live sign-in `user.standard` to prove CA-01 |

## Out of scope

No Intune, no Entra Connect, no Lifecycle Workflows, no Sentinel on this tenant, no Okta.
