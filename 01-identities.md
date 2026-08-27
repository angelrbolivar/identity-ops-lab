# 01 — Identities

27 Aug 2026. Norte Club. Microsoft Entra ID P2 trial.

This is a lab directory, not production Entra.

## Accounts

Two admin accounts and four that hold nothing.

`admin` is the Global Admin I sign into to build this tenant. It is the account I use all day, which is exactly why it is not an emergency account. So I created `breakglass`: a second Global Admin I do not use. It exists for the day `admin` is locked out, broken by a policy I wrote, or phished.

`helpdesk.t1`, `pim.admin`, `user.standard`, and `leaver.marco` have no directory role on day 1. None of them.

![Users](screenshots/01-users.png)

The tenant also carries a leftover personal account, Rusher Ink, from the way the trial was signed up. I leave it alone. It is not a lab user, it gets no group and no role, and I crop it out of screenshots.

## Groups

`GRP-Ops`, `GRP-Finance`, `GRP-IT`. Security groups, Assigned membership, not role-assignable. Members empty.

![Groups](screenshots/02-groups.png)

Not role-assignable is the deliberate part. A role-assignable group is a privilege path, and none of these three need to be one, so I did not leave that door open. Empty members is deliberate too. The containers exist. People go into them when there is a reason to put them there.

## Why helpdesk.t1 is not a standing Global Admin

Tier 1 is the account that gets hit first. It takes requests from strangers all day and its whole job is to be helpful. Standing Global Admin on that account means a successful phish does not get a helpdesk mailbox, it gets the tenant. That is the blast radius I do not want to sign up for.

Same idea I worked with at Remitly: do not leave the powerful action sitting on the account that gets hit first. PIM is the real answer here — elevation on request, with approval and a clock — and it comes later. Today the answer is blunter and still holds. `helpdesk.t1` has nothing to elevate from.

## Scope

PIM, Identity Protection, and Access reviews are visible in the portal on this P2 trial. Visible, not configured. I did not build Administrative Units, custom roles, access packages, or on-prem AD.
