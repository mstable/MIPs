---
tdp: 45
title: mStableDAO Restructure - Election Process
status: Proposed
author: mZeroNine (@mzero2nine)
discussions-to: https://forum.mstable.org/t/tdp-45-mstabledao-restructure-election-process/888
created: 2022-06-24
---

## Simple Summary

It is proposed to put in place the election process for how the mStableDAO will elect the signers for the seats in both the TreasuryDAO and the ProtocolDAO in response to the overall mStableDAO restructuring outlined in [TDP 44](https://mips.mstable.org/TDP/tdp-44.html).

This proposal outlines both the election process, as well as the tasks and responsibilities, terms, and compensation involved.

## Abstract

With the overall restructuring of the mStableDAO, it is important to create a process for electing the signers for both the TreasuryDAO and ProtocolDAO in a way that is easily verifiable, decentralized, and ensures that an agile election process can take place without hindering day to day operations and other related tasks the DAO needs to perform regularly. 

Previously, both DAOs consisted of a mix of entities from both the mStable core team, industry professionals, as well as community members. This new process proposes to do away with specific titles and reserved seats, and instead create one singular universal core contributor title for each signer across the board. 

The “Specification” section lists the exact process that is proposed to be followed for the signer elections, and would be enforced in this way upon successful resolution of TDP 45.

## Motivation

The mStableDAO is transitioning towards a more agile and decentralized structure, and the election process is a key component for this process to be successful. 

By doing away with reserving specific seats for specific entities, we are widening the decentralization aspect of the DAO, while at the same time getting active contributors outside of these groups an opportunity to join the seats of the DAO.

By introducing a universal core contributor title and signer compensation, we are also hardening our DAO against malicious actors that would target specific sub-sections of the DAO and instead streamline and simplify the way anyone can contribute to the mStableDAO in a meaningful and flexible way.

Lastly, we are increasing transparency and accountability for each of the signers inside of the DAO by creating a mandatory rotation via a regular election process to ensure that Meta Governors continuously have an opportunity to chose the signers they deem most fit for the task at hand, and for allowing everyone to verify the process was carried out correctly in line with Governance.

## Specification

The following section highlights the election process, terms, tasks and responsibilities, as well as the compensation of the core contributors in detail and serves as a blueprint for rolling out TDP 45:

### Election process

In order to facilitate the election, the following steps will be conducted:

1. Announcement
    1. A forum post will announce the upcoming election 4 weeks prior to the end of the old term and will remain open for 2 weeks. It details the election process in greater detail, and how to participate as a candidate. Further details that are to be provided by the candidates are outlined in the post (e.g. Ethereum address, signature, URL, short description).
2. Nomination
    1. A member may be nominated or nominate themselves. A nomination has to be accepted by the person in question by responding to the forum post outlined in 1a with the details requested.
    2. A member may be nominated or nominate themselves for both DAOs.
    3. A member that is already part of one of the two DAOs can be nominated for the other DAO, but can never accept seats on both DAOs at the same time to ensure sufficient decentralization.
    4. To ensure that the ProtocolDAO can function in an agile and efficient manner moving forward, two out of the six available seats will be reserved for Builder subDAO members, which will ensure that smart contract upgrades and changes can be queued without needless delays and overhead. These seats will not be up for voting on Snapshot, but nominations for these seats still proceed as outlined in the process here.
3. Election
    1. 2 Snapshot votes will be created for each DAO election after the nomination process has concluded. Multi-winner Ranked choice voting will be used preferably but will be explicitly defined in the forum post outlined in 1a.
    2. (Optionally) Candidates are given time during a community call to introduce themselves.
    3. The vote will be open from Monday to Friday.
4. Acceptance
    1. The candidates with the highest amount of votes may formally accept their election within 7 days after the end of the voting period.
    2. A candidate that accepted the election in one DAO may not accept the election in a second one.
    3. A candidate that does not accept the election will forfeit their position to the next highest in line based on the Snapshot voting result. This also applies if the candidate didn’t accept the result within 7 days as outlined in 4a.
5. Rotation
    1. The candidates that have accepted the election will be rotated into the multisig and added to internal communications channels specified for each of the DAO they got elected into by the Cat Herder.
    2. The rotation will happen on a first in first out basis, one signer at a time with the dedicated ownership swap functionality in the Gnosis Safe Multisig to swap owners of the safe to mitigate risk and maintain the same multisig-structure as proposed during the entire rotation manoeuvre
    3. An elected signer that does not perform the outlined signer tasks may be revoked via signer vote within the DAO (4/6 majority). If this occurs, the next highest candidate will be proposed instead. A detailed policy and process determining failure to performance of duty is to be provided in a separate document following the successful resolution of TDP 45.

### Term length

A core contributor is elected for 6 months, starting from the day of the resolution of the vote. After the first term ends, all seats in the DAOs will be made available again for election. A signer that has served in the past term may run again. There are no maximum amounts of terms hat a signer can run for.

### Core Contributor tasks and responsibilities

Being a core contributor for the TreasuryDAO and ProtocolDAO is an active role, and it does require regular activity and knowledge about the mStable ecosystem and the proposals that are up for execution. This new structure does not allow for passivity and simply signing transactions that are queued in the multisig! 

*The basic tasks and responsibilities of each core contributor are as follows:*

1.) Be available to confirm multi-sig transactions within a 24 hour time window except in rare circumstances, which should be communicated to the Cat Herder at least 24 hours in advance

2.) Be available and willing to participate actively in monthly TreasuryDAO & Governance Signer Calls (4PM UTC)

3.) Have a solid understanding of good OpSec practices, including the mandatory usage of a hardware wallet.

4.) Additionally, TreasuryDAO core contributors should have a sound understanding of DeFi, keep themselves updated on developments and emerging technologies, and be able to read and understand queued multi-sig transactions and their expected behaviour. ProtocolDAO core contributors should have a sound understanding of Solidity, smart contract interactions, and other relevant skills to perform their duties well.

### Core Contributor Compensation

As previously outlined, the core contributor position will come with responsibilities and duties. Therefore a universal core contributor compensation of 1000 mUSD per month is transferred to each community signer to reward them for their time and efforts given to the DAO to their dedicated wallet.

Additional compensation models that are available for core contributors that wish to engage in additional work for the DAO beyond the core tasks above will be outlined separately in TDP 47 together with the process and tooling used to facilitate these.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
