---
tdp: 35
title: Q1 Signer Rotation & Offboarding Clause
status: Proposed
author: mZeroNine (@mzero2nine)
discussions-to: https://forum.mstable.org/t/tdp-35-q1-signer-rotation-offboarding-clause/827
created: 2021-03-04
---

## Simple Summary

It is proposed to rotate a signer in both the TreasuryDAO and the ProtocolDAO. 

With this rotation, it is also proposed to add a new offboarding clause that allows the respective multisigs to eject a signer from the group without prior governance approval, should the corresponding vote on the internal Snapshot page of the DAO be unanimously in favour. 

Onboarding a new replacement signer will still have to go through governance as before. This is done to be able to act swiftly in case of unexpected adversary behaviour.

## Abstract

One of the current core contributors will be ending their term at the end of this month, and currently has an active signer position in both the ProtocolDAO, as well as the TreasuryDAO. 

It is suggested to replace the signer who owns the addresses `0x4B37BbC8CAb32aade27Ce8b1bb2A9E614de81E03` & `0xD8baE7d96df905E46718B6ceE3410F535e11bF20` in both groups with a different core contributor. 

For the ProtocolDAO, it is suggested to onboard `0xb4dB24A77db4A77242F1e7E6Aa346aeCC440f6Df` to the group. This applies to the ProtocolDAO Safe on [Ethereum Mainnet](https://etherscan.io/address/0xF6FF1F7FCEB2cE6d26687EaaB5988b445d0b94a2) as well as on [Polygon](https://polygonscan.com/address/0x429f29a3a36b1b977c3d4ec77c695c3391e7b9ed).

For the TreasuryDAO, it is suggested to onboard `0xB27a7bD98421EB9eAEE522335F45A6F5B65C5C8d` to the main signer group and also to the Asset Management subDAO, both in which he will act in the capacity of lead signer moving forward. This applies to the TreasuryDAO Safe on [Ethereum Mainnet](https://etherscan.io/address/0x3dd46846eed8d147841ae162c8425c08bd8e1b41), as well as the Asset Management subDAO Safe on [Ethereum Mainnet](https://etherscan.io/address/0x67905d3e4fec0c85dce68195f66dc8eb32f59179) and [Polygon](https://polygonscan.com/address/0xC93B5B58739161660BAC4EE20dad74190030623E).

In order to grant the DAO signer groups additional authority during times of urgency and other adverse events, it is also suggested to allow the group to offboard and eject a signer without prior governance approval. This will happen on the internal Snapshot page for the [TreasuryDAO](https://snapshot.org/#/mstabledao.eth) and [ProtocolDAO](https://snapshot.org/#/mstableprotocoldao.eth). 

A unanimous (6/7 signatures for the TreasuryDAO and 7/8 signatures for the ProtocolDAO) vote is required on these platforms before a signer can be removed from the group and a maximum of one signer can be removed at any time from each DAO before another signer needs to be found.

## Motivation

In order to keep the signer group up-to-date, we will occasionally rotate signers in and out, and since `0x4B37BbC8CAb32aade27Ce8b1bb2A9E614de81E03` / `0xD8baE7d96df905E46718B6ceE3410F535e11bF20` is ending their term at the end of this month, we will have to find a suitable alternative for both DAOs. 

Both candidates have been pre-selected internally based upon activity and trustworthiness, and it is the opinion of the ProtocolDAO and TreasuryDAO that they will serve as a sound replacement.

## Specification

1.) Onboard `0xb4dB24A77db4A77242F1e7E6Aa346aeCC440f6Df` to the ProtocolDAO Safe on Ethereum Mainnet and Polygon.

2.) Onboard `0xB27a7bD98421EB9eAEE522335F45A6F5B65C5C8d` to the TreasuryDAO Safe and the Asset Management subDAO Safe on Ethereum Mainnet and Polygon.

3.) Offboard `0x4B37BbC8CAb32aade27Ce8b1bb2A9E614de81E03` / `0xD8baE7d96df905E46718B6ceE3410F535e11bF20` from all respective Safes on both Ethereum Mainnet and Polygon and ensure that all internal voting tokens are transferred to the replacement signers.

4.) Offboard `0x4B37BbC8CAb32aade27Ce8b1bb2A9E614de81E03`as Fund Manager from staking BPT token contract

5.) Offboard `0x4B37BbC8CAb32aade27Ce8b1bb2A9E614de81E03` from the mstablegovernance.eth Snapshot Whitelist

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
