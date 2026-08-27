Light-edit the write-up below. Do not rebuild. Do not add sections. Do not add humility paragraphs.

Keep first person, Norte Club, policy names, What If table, and the limitation that user.standard has never signed in.

Changes required:
1. Embed the screenshots next to the thing they prove, using these exact paths:
![CA-01 On](screenshots/05-ca-mfa-all.png)
![Break Glass excluded from CA-01](screenshots/06-ca-exclude-breakglass.png)
![What If browser — MFA](screenshots/07-whatif-allow-mfa.png)
![What If legacy — block](screenshots/08-whatif-block-legacy.png)
![What If Break Glass user](screenshots/09-whatif-breakglass-user.png)
![What If Break Glass — no policy](screenshots/09-whatif-breakglass-excluded.png)
2. Keep the single line that this is a lab and I do not administer Entra at work. Delete any extra “not production / no experience” wording.
3. Do not add PIM, Okta, Intune, interview scripts, or a hiring-manager section.

Current file:

# 02 — Conditional Access

27 Aug 2026. Norte Club. Entra ID P2 trial.

This is a lab. I do not administer Entra at work.

## What I was trying to do

Get off Security defaults and onto policies I can explain.

I wanted four things:

1. Everyone gets MFA
2. One emergency account does not
3. Old protocols that skip MFA are blocked
4. Admin roles have MFA even if someone later weakens the all-users policy

## What I built

**CA-01-MFA-All-Users**
I built this from a blank policy on purpose. I needed to click Users, Exclude, Grant, and On myself. The templates try to exclude whatever account I am signed in as. That would have excluded admin. admin is the account I work in. The exception is breakglass.

All users. Exclude Break Glass. All cloud apps. Require MFA. On.

I turned Security defaults off only after this policy existed. Microsoft will not let both run.

**CA-02-Block-Legacy-Auth**
I used Microsoft’s “Block legacy authentication” template, then I edited it. The important part of that template is the client list: Exchange ActiveSync and Other clients. If I tick Browser by mistake I lock myself out. If I tick nothing, the policy does nothing.

Same exclude: Break Glass. Grant: Block. On.

**CA-03-MFA-Admins**
Same pattern. Template for “MFA for admins,” then edit. It targets directory roles, not all users. Break Glass is a Global Admin, so I excluded that account or the emergency login would get MFA and the back door would be useless.

On. It overlaps CA-01. That is fine.

I did not use the device-compliance or MDM templates. I have no Intune devices in this tenant.

## Proof

user.standard has never signed in, so I have no real sign-in log for that account. I used What If instead of inventing a failed login.

| Who | Client | What If said | Shot |
|---|---|---|---|
| Standard User | Browser | CA-01 applies. Require MFA. | screenshots/07-whatif-allow-mfa.png |
| Standard User | Other clients | CA-01 wants MFA. CA-02 blocks. Block wins. | screenshots/08-whatif-block-legacy.png |
| Break Glass | Browser | No policy applies. | screenshots/09-whatif-breakglass-user.png and screenshots/09-whatif-breakglass-excluded.png |

Test 3 is two pictures because “0 policies” does not show who you tested.

Policy screenshots: 05-ca-mfa-all.png, 06-ca-exclude-breakglass.png.

## Why I excluded Break Glass and not admin

admin is the daily account. If I exclude it, MFA is theater.

breakglass is standing Global Admin that I do not use. If I include it in CA-01 and Authenticator dies, I have no way back in.

Legacy auth cannot do MFA, so I block it rather than challenge it.

## What this does not prove

- A live sign-in for user.standard
- Named locations
- Intune / device compliance
- Production Entra work

Output the full markdown file.
