---
tdp: 33
title: Community subDAO Creation and Funding
status: WIP
author: Cam Soulsby (@camsoulsby)
discussions-to: https://forum.mstable.org
created: 2021-12-17
---

## Simple Summary

This request is to propose the creation of an mStable Community subDAO and seek ongoing funding for mStable community initiatives including the Metanaut Coordinape circle, payment of Discord Moderators, providing MTA for tipping in Discord, and running events and giveaways for the broader mStable community.

## Abstract

As mStable continues to decentralize and prioritizes building a strong and engaged community, there is a need to be able to reward community members for their contributions to the mStable ecosystem.

While the GrantsDAO focuses on larger projects and more formal relationships, a number of opportunities have been identified which can allow mStable core team members and other community members to distribute rewards fairly to active community members.

The mStable GrantsDAO has provided an initial grant to bootstrap funding for the community initiatives in Q4 2021. This consisted of 11,500 MTA allocated to the following areas:

- Metanaut Coordinape Circle (6000)
- Discord Moderator Payments (3000)
- Contests and giveaways (2000)
- Tipbot (for tipping in Discord) (500)

These funds are currently disbursed via a multisig account controlled by mStable core team members across Operations, Community and Business Development.

In order to continue these successful initiatives, this group is proposing the creation a Community subDAO and requesting ongoing quarterly MTA funding.

## Motivation

Pros

- This funding would provide a sustainable way to incentivize and reward community contribution to the mStable ecosystem.
- Approved ongoing community funding reduces the governance overhead of small individual funding requests.

Cons

- As with any distribution of MTA there is cost to the treasury but we believe that rewarding engaged community members for contribution is a cost effective use.

## Specification

### Use of Funds

Requesting funding of a maximum 14,000 MTA per quarter at the beginning of each quarter, starting in Q1 2022. This amount has been calculated based on the following estimated spending:

- Coordinape: 7500 MTA (Max 2500 MTA per epoch with 3 epochs per quarter)
- Moderator Payments: 4500 MTA (based on estimated MTA price of 1.00 USD)
- Contests and giveaways: 1500 MTA per quarter
- Tipbot: 500 MTA per quarter

We would not expect all of the funds to be used every quarter. To allow only a small buffer to accumulate, the account will be topped up to a maximum of 15,000 MTA each quarter (plus an allowance for any outstanding accounts payable from the previous quarter).

The amounts specified above for each activity should be considered a rough guideline and actual spending may vary quarter to quarter based on requirements. 

### Community subDAO structure and responsibilities

- The Community subDAO would be led by the mStable "Lord of the Discord", Penguin, who would have the responsibility of initiating transactions to disburse funds, keeping accurate records of transactions and communicating with other signers.
- New Gnosis safes will be deployed on Ethereum mainnet and the Polygon PoS network and remaining funds from existing multisig will be transferred to these safes. Safe address will be shared upon approval of this TDP.

- Proposed initial structure is a 2/3 Gnosis Safe with the following signers:
    - Penguin (mStable "Lord of the Discord")
    0xA5DfE92D76590d169d6A622E35E223a07627A2b3
    - Derrick (mStable Growth & Partnerships)
    0x9E0F8D06E68Af898E584C4054474124B092277Dc
    - Cam Soulsby (mStable Operations Lead) 
    0x524269E900ca6ebe2FC57d719995c8D167F8b260
    
- Given the smaller amounts of MTA that will be disbursed by this subDAO, Gnosis Safes will be created on both Ethereum L1 and Polygon PoS. Funds will be bridged and distributed on Polygon unless L1 payments are specifically required.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).