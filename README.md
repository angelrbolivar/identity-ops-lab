# Norte Club — Entra identity lab

Norte Club is a fictional company. I built its first Entra tenant to practice identity operations end to end: create the accounts, write the policies, then prove the policies actually fire.

This is a lab. It is not production Entra.

Author: Angel Rodriguez Bolivar

---

## The tenant

Microsoft Entra ID P2 trial. Started 27 Aug 2026. It expires around 23 Sep 2026.

When the trial dies, the tenant goes with it. The screenshots in [`screenshots/`](screenshots) are the evidence. That is why I write each step down as I do it instead of at the end.

---

## What is built

Two write-ups.

- [01-identities.md](01-identities.md) — the directory. Five users, three groups, plus the admin account I run the tenant from.
- [02-conditional-access.md](02-conditional-access.md) — three Conditional Access policies and the What If evidence for each.

### Accounts

- `admin` — my day-to-day Global Administrator.
- `breakglass` — standing Global Administrator. Never used. Excluded from CA-01.
- `helpdesk.t1` — support account. Not a Global Administrator.
- `pim.admin` — created for privileged role work. Nothing is configured on it yet.
- `user.standard` — baseline staff account.
- `leaver.marco` — baseline staff account.

Groups: `GRP-Ops`, `GRP-Finance`, `GRP-IT`.

### Conditional Access

- **CA-01** — require MFA for all users. `breakglass` excluded.
- **CA-02** — block legacy authentication.
- **CA-03** — require MFA for admin roles.

Security defaults are off. I turned them off after CA-01 was in place, not before. Doing it in the other order leaves a window with no MFA on anything.

### What If results

| Sign-in evaluated | Result |
| --- | --- |
| `user.standard`, browser | CA-01 applies. MFA required. |
| `user.standard`, Other clients | CA-02 applies. Sign-in blocked. |
| `breakglass`, browser | 0 policies apply. |

The third row is the one I re-check. A break-glass account that starts matching CA-01 is an account I cannot use on the day I need it.

---

## Not built

PIM, access reviews, and joiner-mover-leaver do not exist in this tenant. There is nothing to read on them.

---

## Transparency

What If evaluates a described sign-in against policy. It is not a real sign-in. It shows that a policy would apply. It does not show a user completing MFA.

Six accounts. No real users, no real traffic, no real data. The tenant is a few weeks old and rented.

---

## Production work I claim

- Two years of real-time alert triage in fintech fraud and risk operations (Remitly via Sutherland): ATO and fraud queues, high volume, incomplete information, true/false-positive decisions under SLA.
- ABC Fitness: access verification and Ignite RBAC.
- CompTIA Security+.
- Sentinel honeypot lab, in [angelrbolivar-soc-portfolio](https://github.com/angelrbolivar/angelrbolivar-soc-portfolio).

## What I do not claim

I have not administered Entra, Active Directory, Okta, PowerShell, or M365 in production. I do not hold SC-300. This lab does not change any of that.
