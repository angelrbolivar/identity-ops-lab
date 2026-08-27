# Identity Ops Lab — Costa Norte Pay

Fictional gym + payments company. First Entra tenant for staff access.

**This is a lab. Not production Entra.** Production identity work I *do* claim: Remitly ATO/fraud triage and ABC Fitness access verification + Ignite RBAC.

Author: Angel Rodriguez Bolivar  
Tenant: Microsoft Entra ID P2 trial  
Started: 27 Aug 2026  
Trial death clock: ~23 Sep 2026 — screenshots are the evidence

---

## What a hiring manager should look at (5 minutes)

| Order | Artifact | Why it exists |
|---|---|---|
| 1 | [01-identities.md](01-identities.md) | Users, groups, Decision #1 (helpdesk is not standing Global Admin) |
| 2 | [02-conditional-access.md](02-conditional-access.md) | Lab A — MFA-all, break-glass exclusion, block legacy auth, one allow + one block |
| 3 | [03-pim-access-reviews.md](03-pim-access-reviews.md) | Lab B — eligible vs standing privilege |
| 4 | [04-jml-ato.md](04-jml-ato.md) | Lab C — joiner / mover / leaver+ATO mapped to Remitly language |
| 5 | [05-decisions.md](05-decisions.md) | Why each control exists. Alternatives rejected. |
| 6 | [06-limitations.md](06-limitations.md) | What this tenant cannot prove. Do not invent incidents. |

Screenshots live in [`screenshots/`](screenshots/). Cap: 20 named files.

---

## Lab A (hireable this week)

Done when all of these exist in the write-up **and** in `screenshots/`:

- CA: require MFA for all users, exclude `breakglass`
- CA: block legacy authentication
- One admin-targeted CA **or** one named-location test
- Sign-in log evidence: one allow + one block (or What If if interactive sign-in is ugly)
- Decision written: why break-glass is excluded and what compensates

**Until Lab A is published, do not put Entra in a LinkedIn headline.**

---

## Directory (Lab A day 1)

| Account | Purpose |
|---|---|
| `breakglass` | Emergency GA. Excluded from MFA-all CA. Almost never used. |
| `helpdesk.t1` | Least-privilege support. PIM-eligible later. Never standing GA. |
| `pim.admin` | Eligible admin account for PIM demos. |
| `user.standard` | Baseline staff. Target of MFA-all. |
| `leaver.marco` | Disable + revoke + strip groups (ATO / leaver). |

Groups: `GRP-Ops` · `GRP-Finance` · `GRP-IT`

Five users is enough. Pretty roster is not the product. Conditional Access is.

---

## Honest claims

**May claim as production:** Remitly ATO/fraud triage. ABC access verification + Ignite RBAC. Security+. Sentinel honeypot lab.

**May claim as lab after this repo exists:** Entra P2 tenant — CA, PIM, access reviews, JML.

**Never claim as production:** Entra, Active Directory, Okta, PowerShell, M365 admin, SC-300 (until passed).

Related SOC evidence stays here: [angelrbolivar-soc-portfolio](https://github.com/angelrbolivar/angelrbolivar-soc-portfolio)

---

## 60-second interview line

I do access and identity-risk work in production (ABC access tickets + Remitly ATO). I do not administer Entra at work. I built a P2 lab: users/groups, MFA Conditional Access with a break-glass exclusion, PIM-eligible helpdesk, and a finance access review. I can walk joiner, mover, and ATO containment.

If the trial is dead, walk the same order on screenshots. Evidence is the lab.
