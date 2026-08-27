# 01 — Identities

27 Aug 2026. Tenant: Norte Club. Domain: `destinofinalrusheroutlook.onmicrosoft.com`.

The trial was signed up from a personal Outlook account, so there is a leftover account in the directory named Rusher Ink. I leave it there. It is not a lab user, it gets no groups, and I crop it out of every screenshot. Deleting the account the tenant hangs off is not a thing I need to find out about the hard way.

## Accounts

`admin` — Global Administrator. This is the account I actually work in.

`breakglass` — Global Administrator, standing. Password written down and stored offline. I do not sign in with it. It exists because `admin` is not an emergency account. `admin` is the one I use every day, so it is the one most likely to be locked out, broken by a policy I wrote, or phished.

`helpdesk.t1`, `pim.admin`, `user.standard`, `leaver.marco` — no directory role. None of them.

Screenshot: `screenshots/01-users.png`

## Groups

`GRP-Ops`, `GRP-Finance`, `GRP-IT`. All three are Security groups, Assigned membership, not role-assignable.

Not role-assignable is the part worth saying out loud. A role-assignable group is a privilege path, and none of these three need to be one, so I did not leave that door open.

Members are empty on day 1. I built the containers first. People go in when there is a reason to put them in.

Screenshot: `screenshots/02-groups.png`

## The decision I made

Helpdesk is not a standing Global Admin. `helpdesk.t1` holds no role at all.

The reason is the same one I worked with in fraud triage at Remitly: do not leave the powerful action sitting on the account that gets phished first. Tier 1 is the widest attack surface in the building. It takes requests from strangers all day and its job is to be helpful. If a permanent admin role lives on that account, the phish gets the role. PIM is the real answer here — elevation on request, with approval and a clock — and it comes later. Today the answer is cruder and still works: there is nothing on that account to steal.

## P2

PIM, Identity Protection, and Access reviews are visible in the portal on this trial. Visible, not configured.

## Scope

I did not build Administrative Units, custom roles, access packages, or on-prem AD.
