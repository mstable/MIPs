---
mip: 10
title: Extend buyback and make to Feeder Pools
status: WIP
author: Alex Scott (@alsco77), derc (@helloderc), Dimitri Golecko (@dimsomedim)
discussions-to: 
created: 2021-04-09
---

## Simple Summary

It is proposed to redirect a percentage of the system fees from the "Feeder Pools" to the Buyback&Make pool with the initial magnitude of 10%. 

The system revenue redirection has been enabled with [MIP-8](./mip-8) and [PDP-15](https://snapshot.org/#/mstable/proposal/QmRSzC6YXPs6Fy2KT7iicU7MvSQxDAgyGpqGsu16QauRvt) for mAssets and has since been used for the buyback-and-make strategy depositing into [mBPT1](https://pools.balancer.exchange/#/pool/0x02ec2c01880a0673c76e12ebe6ff3aad0a8da968/). Additionally the feeder Pools have been launched with [MIP-9](./mip-9). This Proposal follows both developments and proposes to extend the system fees to the Feeder Pools (a.k.a. fPools).

Revenues from fPools is composed of swap fees into fAssets, fpToken redemption fees, and yield generated from third party lending platforms.

## Abstract
This proposal would set the configurable value "govFee" as specified in [MIP-9](./mip-9) to 10%. 

In addition a new smart contract will be deployed that will collect the fees in fPool LP tokens (a.k.a fpTokens), and exchange these to mAssets (mUSD and mBTC). This will then be sent to the SavingsManager where it will be collected alongside the rest of the mAsset revenue going to buyback-and-make. This smart contract function is called manually will be executed by the signers.

All collected fees will be deposited into the Balancer MTA/ETH/mUSD/mBTC pool. The pool parameters are maintained by the mStable protocolDAO with the collateral owned by the system & vMTA holders.

## Motivation
The system fees have been enabled for other parts of the mStable ecosystem. With the addition of the Feeder Pools the extension of the system fees to these pools is a rational step in order include all parts of mStable into the generation of revenue.

In addition the ProtocolDAO identified these benefits:

- Great reflexivity effect on the MTA token value which boosts APY % (which in turn boosts liquidity and swap fees).
- Feeder Pools directly drive system revenue in the mStable ecosystem through deeper liquidity and higher swap volume.
- Impact on return to liquidity providers is minimal while direct system revenue increases the MTA token value.
## Specification

Most of the components for this MIP already exist - namely the ability for Feeder Pools to collect a percentage of their revenue using the configurable parameter "govFee". With this in mind, the MIP describes the method by which the fpTokens will be collected and converted into the aforementioned mBPT token:

1. `InterestValidator` contract will be deployed with a function `collectGovFees(address[] calldata _fPools)`
2. This function will collect the fpTokens from an array of pools and call `fpToken.redeem(mAsset..` to convert them back into the underlying mAsset
3. The underlying mAsset will be transferred to the `SavingsManager` , and will be included in the next collection of the core mAsset revenue along the process outlined in `MIP-8`

`InterestValidator` will be added as a system module, allowing it to call `collectPendingFees` on each fPool.


## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
