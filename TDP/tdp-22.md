---
tdp: 22
title: BadgerDAO Loan for Bootstrapping MTA Vault Boost
status: Implemented
author: mZeroNine (@mzero2nine)
discussions-to: https://forum.mstable.org/t/mdp22-badgerdao-loan-for-bootstrapping-mta-vault-boost/579
created: 2021-08-20
---

## Simple Summary

After [successful internal motion](https://snapshot.org/#/mstabledao.eth/proposal/QmQRe4FaRzzQf7w88HYRb7mCxqJLm7Sia6VoaX3Z9s8odR), it is proposed to lend the BadgerDAO a sum of 500,000 MTA for 90 days in order to help bootstrap the MTA boost received for users of their platform in the imBTC and mBTC/HBTC Vaults, once these get deployed on the [Badger dApp](https://app.badger.com/).

## Abstract

The loan is given in a trustless fashion via a loan function on the deployed [MStableVoterProxy](https://etherscan.io/address/0x10D96b1Fd46Ce7cE092aA905274B8eD9d4585A6E) contract that is managed by both the mStable Protocol DAO and the BadgerDAO.

Through shared ownership, the VoterProxy has the ability to deposit this loaned MTA into the mStable Staking contract, and consequently manage this stake (for example, migrating to a new staking contract when it goes live).

After the term ends, the loaned out MTA will flow back into the mStableDAO Funding subDAO treasury, and a configurable percentage of accrued rewards from this loan will remain in the VoterProxy contract to help bootstrap an initial boost for the BadgerDAO and its users.

Depending on initial success of these vaults, the loan duration can potentially be extended to retain a competitive boost on the Vaults, which will mandate an additional formal vote by Meta Governors at least 14 days before the extension would take place.

## Motivation

The mStable core contributor team has worked diligently to get part of our mBTC ecosystem integrated with other protocols, and this collaboration with Badger marks the fruit of a long period of a joint development effort.

In order to assist the BadgerDAO attract a high return for these new products in the launch phase, we’re now asking Meta Governors to decide if this assistance should be granted to them and their users.

This short-term loan will benefit the mStable protocol, as every active user on their platform will have a direct net positive effect for mStable’s own TVL. It will also highlight the collaboration and interconnectedness between the two protocols and help set a solid foundation for further mutually beneficial endeavors.

## Specification

The Funding subDAO will loan out the agreed upon amount of MTA for the duration by depositing the MTA into this VoterProxy contract.

From there, the MTA will be deposited into our existing staking contract to be eligible to receive a boost on the imBTC Vault, as well as the mBTC/HBTC Feeder Pool, and the staking duration has to be less than the loan duration in order to be able to pay back the loan in due time.

A percentage of rewards received from staking and for providing liquidity will remain in the VoterProxy contract at the end of the term to assist with maintaining a boost for these positions in the long-term.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
