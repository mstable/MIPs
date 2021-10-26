---
mip: 18
title: Add mUSD/FEI Feeder Pool
status: Proposed
author: Dimitri Golecko (@dimsome)
discussions-to: https://forum.mstable.org/t/pdp-34-add-musd-fei-feeder-pool/670
created: 2021-10-13
---

## Simple Summary

It is proposed to add an mUSD/FEI Feeder Pool as specified in [MIP 9](./mip-9) on Ethereum mainnet. FEI is an algorithmic stablecoin that is collateralized by PCV (Protocol Controlled Value) and is fully decentralised.

## Abstract

FEI is an algorithmic stablecoin that is collateralized by PCV (Protocol Controlled Value) and is fully decentralised. The Fei Protocol primarily funds PCV via bonding curve FEI issuance. The bonding curve mints FEI in exchange for PCV at an oracle determined ETH exchange rate.

The addition of an mUSD/FEI Feeder Pool would allow users holding FEI to participate in the mStable's ecosystem and benefit from seamless deposits directly into Save and withdrawals back into FEI. FEI has also a lending market on Aave V2 that could enhance the yield in the Feeder Pool.

## Motivation

mStable's ethos of decentralization should be reflected by the assets it includes in the protocol. The addition of the FEI Feeder Pool is a further step into stable assets that are fully decentralized and therefore offers a lower risk of Nationstate's interference. Additionally, there is a strong signal from the FEI Tribe to support this pool.

## Specification

A new instance of the `FeederPool` contract will be deployed with the following parameters:

- Name: mUSD/FEI Feeder Pool
- Symbol: fPmUSD/FEI
- Amplitude coefficient (A): 100
- Swap fee: 0.04% (4 basis points)
- Redemption fee: 0.04% (4 basis points)
- Governance fee: 10% of fees charged
- Min bAsset weight limit: 3%
- Max bAsset weight limit: 97%
- FEI integration: FEI has a market on AaveV2, the contract `AaveV2Integration.sol` will be used allowing to earn native lending yield.
- mUSD integration: none initially, integration can be added later.

The `mUSD` smart contract address is `0xe2f2a5c287993345a840db3b0845fbc70f5935a5`

The `FEI` smart contract address is `0x956F47F50A910163D8BF957Cf5846D573E7f87CA`

A new instance of the contract `BoostedDualVault` for the vault for the mUSD/FEI Feeder Pool will be deployed to accommodate dual rewards with the following parameters:

- Name: v-mUSD/FEI fPool Vault
- Symbol: v-fPmUSD/FEI

## Permissions

This MIP grants the ProtocolDAO permission to adjust the Amplitude coefficient (A) when deemed necessary.

Additionally, an Iron Bank integration (or any other Integration that was approved by a previous proposal) can be added later, when deemed beneficial.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
