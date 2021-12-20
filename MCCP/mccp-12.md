---
mccp: 12
title: Whitelist BalancerDAO Gnosis Safe in Staking V2
status: Proposed
author: Dimitri Golecko (@dimsome)
discussions-to:
created: 2021-12-120
---

## Simple Summary

We recently conducted a token swap with Balancer DAO([TDP 29](../TDP/tdp-29)). This swap was executed and Balance DAO is now wanting to stake the acquired MTA. This can be only done when we whitelist the multisig address in the Staking V2 ([MIP 15](../MIPS/mip-15) ) contract. It is therefore proposed to whitelist the Balancer DAO Gnosis Safe in Staking V2

## Abstract

With the introduction of [Staking V2](../MIPS/mip-15), we introduced a limitation that only Externally Owned Accounts (EOA) can stake MTA or mBPT. The functionality to whitelist certain contract addresses was added. This proposal requests to whitelist the Balancer DAO multisig:

`0x10A19e7eE7d7F8a52822f6817de8ea18204F2e4f`

## Motivation

Since we conducted the token swap with Balancer DAO, the MTA should be able to be used in the Staking V2 contract and subsequently to vote on dials. The intent was to give Balancer DAO a voice in the Emissions Controller and allow them to vote on their pools. We should whitelist this address because this was the intention of the swap from the beginning.

## Specification

To whitelist the Balancer DAO multisig the following transactions will be executed by the ProtocolDAO multisig:

- [Staked MTA (stkMT](https://etherscan.io/token/0x8f2326316ec696f6d023e37a9931c2b2c177a3d7))
  - `0x8f2326316eC696F6d023E37A9931c2b2C177a3D7`:
  - `whitelistWrapper(0x10A19e7eE7d7F8a52822f6817de8ea18204F2e4f)`
- [Staked Token BPT (stkBPT)](https://etherscan.io/token/0xefbe22085d9f29863cfb77eed16d3cc0d927b011)
  - `0xeFbe22085D9f29863Cfb77EEd16d3cC0D927b011`:
  - `whitelistWrapper(0x10A19e7eE7d7F8a52822f6817de8ea18204F2e4f)`

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/)
