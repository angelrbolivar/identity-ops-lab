# 02 — Conditional Access (Lab A)

Date: 27 Aug 2026  
Status: policies On + What If evidence captured

## Goal

Replace Security defaults with Conditional Access a junior IdP operator would actually ship: MFA-all, named break-glass exclusion, block legacy auth, one role-scoped admin policy.

## Policies

| Policy | How built | Include | Exclude | Grant | State |
|---|---|---|---|---|---|
| CA-01-MFA-All-Users | Blank | All users | Break Glass | Require MFA | On |
| CA-02-Block-Legacy-Auth | Template, then edited | All users | Break Glass | Block (legacy clients) | On |
| CA-03-MFA-Admins | Template, then edited | Privileged directory roles | Break Glass | Require MFA | On |

Security defaults: **Off** after CA-01 was ready to enforce. Defaults and CA cannot both own MFA.

## Why blank vs template

- CA-01 blank: learn Users / Exclude / Grant / Enable. Templates auto-exclude the signed-in admin. Wrong emergency account.
- CA-02 template: client-app list (Exchange ActiveSync + Other clients) is easy to mis-tick from memory.
- CA-03 template: privileged role set is easy to under-scope if you only tick Global Admin.

## What If evidence

User: `user.standard`. Cloud app: Office 365. Device: Windows.

1. Client = Browser → CA-01 applies, Require MFA. CA-02 and CA-03 do not.  
   `screenshots/07-whatif-allow-mfa.png`
2. Client = Other clients → CA-01 Require MFA **and** CA-02 Block access. Block wins.  
   `screenshots/08-whatif-block-legacy.png`

No interactive sign-in log for `user.standard` yet. That account has never signed in. What If is the evidence. Limitation written on purpose — not a fake 401.

## Decision

**Decision:** Exclude Break Glass from enforcing CA. Do not exclude `admin`.  
**Alternative rejected:** Leave Security defaults on, or exclude the daily operator so MFA is theater.  
**Why:** Defaults are a blunt switch. CA is scoped. The emergency account is unused standing GA; the operator account must take MFA. Legacy clients bypass MFA, so they are blocked rather than challenged.  
**Screenshots:** `05-ca-mfa-all.png` `06-ca-exclude-breakglass.png` `07-whatif-allow-mfa.png` `08-whatif-block-legacy.png`
