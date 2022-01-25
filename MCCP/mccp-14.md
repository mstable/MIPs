---
mccp: 14
title: Whitelist Abachi Multisig in Staking V2
status: Implemented
author: 3L3C70 (@FaysalM)
discussions-to: https://forum.mstable.org/t/mccp-14-whitelist-abachi-multisig-in-staking-v2/772
created: 2022-01-14
---

## Simple Summary

[Abachi](https://www.abachi.io/) acquired recently some MTA and would like to stake this in Staking V2 on mStable. The MTA is in the Multi-sig and Abachi to stake MTA from the Gnosis Safe Multisog. Abachi plans to acquire more MTA both via buying from the market and our MTA and Stable pools. These will be added to the treasury backing and staked in the future.

## Abstract

With the introduction of [Staking V2](../MIPS/mip-15), we introduced a limitation that only Externally Owned Accounts (EOA) can stake. Additionally, the functionality to whitelist certain contract addresses was added.

This Proposal requests to whitelist the following address in Staking V2: `0x6FcE4c6CDd8C4e6C7486553D09BdD9aEE61cF095`

## Motivation

Abachi recently started to use mStable Save for generating yield:

1. 500k into Save on Ethereum Mainnet.
2. 500k into Save on Polygon

Alongside this investment, MTA was acquired as well to use in Staking V2. This would allow us to boost our MTA rewards, participate in governance and represent our interests within the mStableDAO.

## Specification

To whitelist the Abachi Multisig the following transactions will be executed by the ProtocolDAO Multisig:

- [Staked MTA (stkMT)](https://etherscan.io/token/0x8f2326316ec696f6d023e37a9931c2b2c177a3d7)

  - `0x8f2326316eC696F6d023E37A9931c2b2C177a3D7`:
  - `whitelistWrapper(0x6FcE4c6CDd8C4e6C7486553D09BdD9aEE61cF095)`

- [Staked Token BPT (stkBPT)](https://etherscan.io/token/0xefbe22085d9f29863cfb77eed16d3cc0d927b011)

  - `0xeFbe22085D9f29863Cfb77EEd16d3cC0D927b011`:
  - `whitelistWrapper(0x6FcE4c6CDd8C4e6C7486553D09BdD9aEE61cF095)`

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/)
