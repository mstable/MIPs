---
mip: 21
title: Community signer election
status: Proposed
author: Dimitri Golecko (@dimsome)
discussions-to: https://forum.mstable.org/t/pdp-37-community-signer-election/696
created: 2021-11-1
---

## Simple Summary

It is proposed to allocate seats in the ProtocolDAO and the TreasuryDAO to community members. For the ProtocolDAO, 2 seats are made available for election, whereas the TreasuryDAO adds one seat. This proposal outlines the election process and the tasks of the community signers.

## Abstract

As the mStable ecosystem grows, so does the need to decentralise it further. The previous proposal, MIP XX outlined a new and improved structure to put governance into the hand of the community. A second step to add further to this decentralisation model in a gradual matter is to allow prominent core community members (Metanauts) to participate in the governing bodies of mStable, namely the ProtocolDAO and TreasuryDAO.

Since mStable’s inception, the roles of the signers in both DAOs have been filled with either core contributors or known members of the industry. This was done to mitigate the concentration of risk while still distributing power. Now that the ecosystem can boast an established base of Metanauts around mStable, we should revisit these positions and allow more community participation and transparency.

This proposal does not propose to change the TreasuryDAO subDAOs structure, nor the GrantsDAO.

## Motivation

This marks the next step of decentralising the DAOs of mStable further. This follows the long-term goal that mStable is to be “controlled not by a single entity but by a global community of Meta Governors.” This step will also add more transparency towards the multisig transactions performed by the two DAOs, and an additional instance of reaffirmation by the community.

The proposed election process is also to be regarded as an experiment on the road towards further decentralisation. This is the first iteration of its kind, and subsequent election periods should improve this process and pave the road to being fully autonomous in the future.

## Specification

The ProtocolDAO and TreasuryDAO signer structure is proposed to be altered in the following ways:

### ProtocolDAO

The existing core contributor signers will remain untouched by this process. A signer rotation within this group remains at the discretion of the DAO to nominate an individual, and to ratify the nomination via public vote. The 2 industry professionals will be replaced with core community members that are selected via an election process outlined in this proposal.

The new constellation will be as follows:

- 6 Core Contributors
- 2 Community members (up for election)

### TreasuryDAO

The existing core contributor signers will remain untouched by this process. A signer rotation within this group remains at the discretion of the DAO to nominate an individual, and to ratify the nomination via public vote. The 4 independent signers will remain as well until further adjustments are proposed and ratified. The DAO will be extended with one seat that will be filled with a core community member selected via an election process outlined in this proposal.

The new constellation will be as follows:

- 2 Core Contributors
- 4 Independent signers
- 1 Community member (up for election)

### Election process

In order to facilitate the election, the following steps will be conducted:

1. Announcement
   1. A forum post will announce the upcoming election. It details the election process in greater detail, and how to participate as a candidate. Further details that are to be provided by the candidates are outlined in the post (e.g. Ethereum address, signature, URL, short description).
2. Nomination
   1. A member may be nominated or nominate themselves. A nomination has to be accepted by the person in question by responding to the forum post outlined in 1a with the details requested.
   2. A member may be nominated or nominate themselves for both DAOs.
   3. A member that is already part of one of the two DAOs cannot be nominated for the other (excluding GrantsDAO and subDAOs).
3. Election
   1. 2 Snapshot votes will be created for each DAO election. Ranked-choice voting will be used preferably but will be explicitly defined in the forum post outlined in 1a.
   2. (Optionally) Candidates are given time during a community call to introduce themselves.
   3. The vote will be open from Monday to Friday.
4. Acceptance
   1. The candidate (TreasuryDAO) or the two candidates (ProtocolDAO) with the highest amount of votes may formally accept their election within 7 days after the end of the voting period.
   2. A candidate that accepted the election in one DAO may not accept the election in a second one.
   3. A candidate that does not accept the election will forfeit their position to the next highest in line based on the SnapShot vote. This also applies if the candidate didn't accept the result within 7 days as outlined in 4a.
5. Rotation
   1. The candidate or candidates that have accepted the election will be rotated into the multisig and added to internal communications channels specifically for signer duties.
   2. An elected signer that does not perform the outlined signer tasks may be revoked via a signer vote within the DAO. If this occurs within the first month after the election, the next highest candidate will be proposed. In the case that this occurs later than that, the seat remains unoccupied until the next election.

### Term length

A community signer is elected for 6 months, starting from the day of the resolution of the vote. After the first term ends, all community seats will be made available again for election. A signer that has served in the past term may run again. There are no maximum amounts of terms hat a signer can run for.

### Community signer tasks and responsibilities

Being a signer is an active role, and it does require regular activity and knowledge about the mStable ecosystem and the proposals that are up for execution.

Additional requirements are the following:

- Highest security practices for secure signing (e.g. Hardware Wallet)
- Availability for signing on a regular basis (ad-hoc signing might be required)
- Monthly signer calls
- Prior experience with Gnosis Safe multi-sig is helpful
- Support with additional tasks (if signer chooses to extend participation)

For the ProtocolDAO additional technical background is preferred. For the TreasuryDAO, some expertise for responsible treasury management and its underlying processes is preferred.

### Community signer stipend

As previously outlined, the community signer position will come with responsibilities and duties. Therefore a signer stipend of 1000 USD in MTA (calculated as the 30 WVAP) per month is transferred to each community signer to compensate them for their time and efforts.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
