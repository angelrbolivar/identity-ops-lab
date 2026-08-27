# Norte Club — Entra identity lab

Norte Club is a fictional gym and payments company. I built its Entra tenant from scratch so I could do identity work end to end instead of reading about it. Angel Rodriguez Bolivar.

Microsoft Entra ID P2 trial. Started 27 Aug 2026. The trial ends around 23 Sep 2026 and the tenant goes with it, so the screenshots are the evidence.

## What I do in production

At ABC Fitness I verify the requester's identity first, then change their access in Ignite. Password resets are gated to L3, so I route those instead of doing them.

At Remitly I triaged ATO and fraud alerts in a live queue under SLA: release, hold, or block, on incomplete information.

CompTIA Security+. My detection work lives in [angelrbolivar-soc-portfolio](https://github.com/angelrbolivar/angelrbolivar-soc-portfolio) (Sentinel honeypot).

I do not administer Entra, Okta, AD, or M365 at work. That is the gap this lab is closing.

## Users and groups

![Norte Club users](screenshots/01-users.png)

Five users, plus the `admin` account I run the tenant from.

`admin` is the Global Admin I work in every day. `breakglass` is a standing Global Admin I do not use, excluded from Conditional Access, because the account I work in is not an emergency account. `helpdesk.t1`, `pim.admin`, `user.standard`, and `leaver.marco` hold no directory role at all.

Groups: `GRP-Ops`, `GRP-Finance`, `GRP-IT`.

Full write-up: [01-identities.md](01-identities.md)

## Conditional Access

![CA-01 On](screenshots/05-ca-mfa-all.png)

Three policies, all On.

- **CA-01** — require MFA for all users. `breakglass` excluded.
- **CA-02** — block legacy authentication.
- **CA-03** — require MFA for privileged roles.

I tested each one with What If:

| Account | Client | Result |
|---|---|---|
| `user.standard` | Browser | CA-01 applies. MFA required. |
| `user.standard` | Other clients | CA-02 applies. Blocked. |
| `breakglass` | Browser | No policy applies. |

The last row is the one I re-check. If `breakglass` ever starts matching CA-01, the emergency account has stopped being an emergency account.

Full write-up: [02-conditional-access.md](02-conditional-access.md)

## Not in this repo yet

PIM, access reviews, joiner-mover-leaver, and Okta. Not built.
