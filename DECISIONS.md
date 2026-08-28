# Decisions

Only decisions that are already true in the tenant. No planned work.

## admin stays in Conditional Access

28 Aug 2026.

`admin` is the account I sign into all day. Excluding it makes MFA theater. CA-01/02/03 include it.

## breakglass is the only CA exclude and the only standing emergency GA

28 Aug 2026.

`admin` can be locked out by a policy I wrote, a dead Authenticator, or a phish. `breakglass` exists for that day. I do not use it to build the lab.

## helpdesk.t1 has no standing directory role

28 Aug 2026.

Tier-1 takes requests from strangers. Standing privilege on that account is the blast radius I will not sign up for. PIM for Groups is how T1 will elevate later. It is not built yet.

## Privileged change needs a ticket

28 Aug 2026.

Requester, verification, before, after, rollback. NC-001 is the first ticket. It is a proof sign-in, not a privilege grant.
