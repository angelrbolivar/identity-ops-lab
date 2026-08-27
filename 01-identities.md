# 01 — Identities

Date: 27 Aug 2026

## Decision #1

**Decision:** Helpdesk is not standing Global Admin.  
**Date:** 27 Aug 2026  
**What I configured:** Five fictional users and three groups. `helpdesk.t1` has no directory role on day 1. Privileged work later goes through PIM eligibility on `helpdesk.t1` / `pim.admin`.  
**Alternative I rejected:** Make helpdesk standing Global Admin “so tickets are faster.”  
**Why:** Standing GA on a T1 account is ATO blast radius. Remitly taught the same rule in a different product: do not leave the powerful action sitting on the account that gets phished first.  
**Screenshot:** `screenshots/01-users.png`, `screenshots/02-groups.png`

## Users created

| UPN / name | Purpose | Directory role day 1 |
|---|---|---|
| breakglass | Emergency only. CA exclusion. | Global Admin (standing, unused) |
| helpdesk.t1 | Tier-1 support | None |
| pim.admin | PIM demo account | None (eligible later) |
| user.standard | Baseline staff | None |
| leaver.marco | Leaver + ATO | None |

## Groups created

- `GRP-Ops`
- `GRP-Finance`
- `GRP-IT`

## Notes from the portal

- P2 blades confirmed visible: PIM / Identity Protection / Access reviews — yes / no (fill after you click)
- Security defaults: leave on until Lab A CA exists, then replace with CA and turn defaults off. Do not leave the tenant open.
- No real Remitly / ABC / customer names in this tenant.

## What I did not do today

- Administrative Units
- Custom roles
- Access packages
- Hyper-V / on-prem AD
- Nine-user Costa Norte roster (optional flavor, not required)
