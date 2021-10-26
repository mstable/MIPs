---
mip: 16
title: Add mBTC/tBTC v2 Feeder Pool
status: Approved
author: Dimitri Golecko (@dimsome)
discussions-to: https://forum.mstable.org/t/pdp-30-add-mbtc-tbtc-v2-feeder-pool/654
created: 2021-09-30
---

## Simple Summary

It is proposed to add a mBTC/tBTC v2 Feeder Pool as specified in [MIP 9](./mip-9). This Feeder Pool will replace the current [mBTC/tBTC Feeder Pool](https://etherscan.io/address/0xb61a6f928b3f069a68469ddb670f20eeeb4921e0) and incentives should migrate to the newly created pool. This upgraded tBTCv2 asset is launched by [Threshold Network](https://forum.threshold.network/) that recently was born out of a merger from Keep and NuCypher. The tBTC v2 addresses drawbacks of scalability that was present in v1.

## Abstract

It is proposed to add an mBTC/tBTC v2 Feeder Pool. The MTA rewards are also to be redirected from the existing mBTC/tBTC Feeder Pool to the one proposed here.

tBTC is a fully trustless, decentralized and censorship-resistant asset bridge between bitcoin and Ethereum blockchains. It is built to give Bitcoin the capabilities of Ethereum and bring additional collateral to DeFi. The asset is an ERC-20 pegged to Bitcoin, it can be minted or redeemed for BTC by anyone and without intermediaries. Instead of relying on a single custodian like wBTC or federation of custodians like Liquid, tBTC is supported by a decentralized bonded multi-federated peg model using ECDSA technology. Being alive and without incidents for a whole year, reassures that in spite of being a cornerstone of advanced cryptographic achievements TBTC works as intended.

With tBTC v1 a drawback has proven to be its scalability. Capital intensity imposed restrictions on the system’s ability to grow beyond a certain point. tBTC v2 addresses this drawback while enhancing the trustless decentralized features of v1.

Keep Network and NuCypher combined their collective efforts in a new project called Threshold Network. tBTC v2 is the first project to launch under the new structure.

The contract to swap tBTC v1 to tBTC v2 is accessible for users at the address: `0x6590DFF6abEd7C077839E8227A4f12Ec90E6D85F`

After the launch of the mBTC/tBTC v2 Feeder Pool, MTA incentives for the mBTC/tBTC v1 Feeder Pool will not be topped up anymore and therefore incentivising the migration to tBTCv2 and the newly deployed Feeder Pool.

## Motivation

The proposed Feeder Pool is the natural continuation of supporting the tBTC asset. The upgraded tBTC contract addresses limitations while preserving decentralization and trustlessness. mStable is one of the first to launch a tBTCv2 Pool and is posed to capture the majority of swap volume for this asset. At the same time, users can bridge their BTC over to Ethereum in a trustless manner via tBTCv2 and access yield products offered by mStable.

Additionally, this would enhance the partnership with the newly formed Threshold Network and open up the possibility for dual incentives; Threshold Network is planning to launch its new token T and is actively looking to incentivise liquidity. This would make this Feeder Pool an attractive choice for investors who seek yield on their BTC on Ethereum.

## Specification

A new instance of the `FeederPool` contract will be deployed with the following parameters:

- Name: mBTC/tBTCv2 Feeder Pool
- Symbol: fPmBTC/tBTCv2
- Amplitude coefficient (A): 100
- Swap fee: 0.04% (4 basis points)
- Redemption fee: 0.04% (4 basis points)
- Governance fee: 10% of fees charged
- Min bAsset weight limit: 3%
- Max bAsset weight limit: 97%

The `mBTC` smart contract address is `0x945facb997494cc2570096c74b5f66a3507330a1`

The `tBTCv2` smart contract address is `0x18084fbA666a33d37592fA2633fD49a74DD93a88`

A new instance of the contract `BoostedDualVault` for the vault for the mBTC/tBTCv2 Feeder Pool will be deployed to accommodate dual rewards with the following parameters:

- Name: v-mBTC/tBTCv2 fPool Vault
- Symbol: v-fPmBTC/tBTCv2

After deploying this Feeder Pool contract, MTA incentivisation for the existing Feeder Pool at the address `0xb61a6f928b3f069a68469ddb670f20eeeb4921e0` with the vault address `0x760ea8cfdcc4e78d8b9ca3088ecd460246dc0731` would expire and not topped up anymore.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
