---
mccp: 15
title: Whitelist Multisigs in Staking V2
status: WIP
author: Dimitri Golecko (@dimsome)
discussions-to:
created: 2022-01-25
---

## Simple Summary

It is proposed to allow the ProtocolDAO to whitelist all multisigs to stake in [Staking V2](../MIPS/mip-15) upon request. Since multisigs are smart contracts this step is required before they can interact with the smart contracts and stake MTA or mBPT. This would allow for a streamlined process of requests and less governance overhead.

## Abstract

Staking V2 added a limitation to the contract that only allows EOA (Externally Owned Accounts) to stake. An option to whitelist wrapper contracts was added as well that bypasses this limitation.

It is proposed that the ProtocolDAO would receive requests from Multisig owners to be whitelisted, then check the contract and queue the transaction directly, without the need to create a proposal and follow the lengthy governance process.

Proper transparency will be still preserved and all transactions to whitelist a Multisig will be communicated and collected in one place.

## Motivation

Recently, this limitation meant that each Multisig would also need to be whitelisted with an accompanying proposal. This adds a lot of overhead and delays the process. We should allow the ProtocolDAO to whitelist all Multisigs upon request from the Multisig owners immediately without the need to go via governance.

In general, following the ethos of permissionless and decentralisation, all Multisigs should be able to stake MTA if they wish so, without the need for permission via governance. The initial intention of the limitation around smart contracts interactions with Staking V2 was not to slow down the process of Multisigs staking, but rather to mitigate certain functionalities within wrapper contracts for Staking V2.

## Specification

A Multisig can be requested to be whitelisted by either contacting a member of the team, the Cat Herder or directly in the forum. Upon request, a signer of the Multisig or the Cat Herder will check and verify via Etherscan that the requested address is indeed a Multisig. After which a transaction in the ProtocolDAO Multisig can be queued to whitelist the requested address:

- [Staked MTA (stkMT)](https://etherscan.io/token/0x8f2326316ec696f6d023e37a9931c2b2c177a3d7)
  - `0x8f2326316eC696F6d023E37A9931c2b2C177a3D7`:
  - `whitelistWrapper(address multisig)`
- [Staked Token BPT (stkBPT)](https://etherscan.io/token/0xefbe22085d9f29863cfb77eed16d3cc0d927b011)
  - `0xeFbe22085D9f29863Cfb77EEd16d3cC0D927b011`:
  - `whitelistWrapper(address multisig)`

Each signer should confirm and check the validity of this request.

A thread in the forum will be created to collect all whitelist requests and will be updated upon new requests.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/)
