---
mccp: 21
title: Stake BPT staked in mStable into Balancer Staking contracts
status: Implemented
author: derc (@derc), Nick Addison (@naddison36)
discussions-to: https://forum.mstable.org/t/rfc-stake-bpt-staked-in-mstable-into-balancer-staking-contracts/
created: 2022-04-12
---

## Simple Summary

It is proposed to upgrade mStable’s staking contracts to support staking MTA/ETH BPT tokens currently staked on mStable into Balancer’s new staking contracts for continued BAL LM rewards

## Abstract

Balancer has [launched veBAL](https://medium.com/balancer-protocol/vebal-is-live-aeda1ae13e20) with a new set of staking contracts where Balancer LPs must now stake their LP Tokens (BPTs, Balancer Pool Tokens) to continue to receive liquidity mining incentives.

mStable governors staking the 80/20 MTA/ETH BPT tokens in the staking contract do not enjoy new BAL emissions, which the mStableDAO is currently voting for the pool from the rewards from the [token swap previously announced](https://medium.com/balancer-protocol/mstable-and-balancer-dao-announce-treasury-swap-e0b031b2387d) with Balancer and other veBAL holders voting for MTA/ETH pool.

It is proposed to upgrade the staking contracts to support BPT tokens currently staked in mStable to be further staked into Balancer’s new staking contracts for liquidity mining incentives, currently with fully automated BAL minting and inflation schedule locked.

Note that mStable’s MTA/ETH pools on Balancer currently receive [~0.8% of voting power](https://app.balancer.fi/#/vebal) rewards, and possibly more in future when Convex-esque platforms like [Aura Finance](https://forum.balancer.fi/t/proposal-allowlist-aura-finance-in-balancer-votingescrow/2708) launch and bribes are implemented in future.

## Motivation

MTA/ETH stakers taking part in mStable’s governance can continue receiving BAL LM rewards which have transitioned into a staking model. Furthermore, continued LM rewards will support or increase buy pressure to support MTA’s token price, and upside to MTA secondary market price would support our own LM incentives and ecosystem.

## Specification

Instead of the [mStable MTA/WETH Staking BPT (mBPT)](https://etherscan.io/address/0xe2469f47ab58cf9cf59f9822e3c5de4950a41c49) being held in the [Staking Token BPT (stkBPT)](https://etherscan.io/address/0xeFbe22085D9f29863Cfb77EEd16d3cC0D927b011) contract, it would be deposited into the new [Balancer mBPT Gauge Deposit (mBPT-gauge)](https://etherscan.io/address/0xbec2d02008dc64a6ad519471048cf3d3af5ca0c5).

Detailed functional changes to the `StakedTokenBPT` contract:

- Add immutable `balancerGauge` variable that contains the address of the new [Balancer mBPT Gauge Deposit (mBPT-gauge)](https://etherscan.io/address/0xbec2d02008dc64a6ad519471048cf3d3af5ca0c5) and implements the new IBalancerGauge interface.
- As `balancerGauge` is immutable, it must be set in the constructor.
- A new function added to
  - approve the new Balancer gauge contract to transfer mBPT from the `StakedTokenBPT` contract.
  - Migrate all the mBPT held in the `StakedTokenBPT` contract to the new Balancer gauge.
- Modify the `setBalRecipient` function so the default rewards receiver is set on the new gauge instead of the old `balRecipient` storage variable.
- Modify the `convertFees` function so
  - the mBPT balance of the `StakedTokenBPT` contract is retrieved from the new gauge rather than the `StakedTokenBPT`'s mBPT balance.
  - pending mBPT fees are withdrawn from the gauge before the balancer pool is used to swap mBPT for MTA.
- Modify the internal `_transferAndStake` function so mBPT is transferred to the new gauge after mBPT is transferred into the `StakedTokenBPT` contract.
- Modify the internal `_withdrawStakedTokens` function so mBPT is withdrawn from the gauge before mBPT is transferred to the withdrawal recipient.
- Add a new internal `_balanceOfStakedTokens` function that gets the mBPT balance staked in `StakedTokenBPT` from the new Balancer gauge.

Functional changes to the parent `StakeToken` contract:

- Make internal function `_transferAndStake` virtual so it can be overridden by `StakedTokenBPT`.
- Add a new internal `_withdrawStakedTokens` function that transfer's mBPT to the recipient by default but can be overridden by `StakedTokenBPT` to withdraw mBPT from the new Balancer gauge.
- Add a new internal `_balanceOfStakedTokens` function that
  gets the balance of the staked MTA or mBPT tokens. By default it gets
  the balance of the staked tokens held in the staking contract but can be overridden by `StakedTokenBPT` which gets the balance from the new Balancer gauge.

A new `IBalancerGauge` interface with the following functions is added:

- deposit
- withdraw
- set_rewards_receiver

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/)
