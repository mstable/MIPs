---
mip: 3
title: Add a cache to reduce gas costs
status: Approved
author: Alex Scott <alex@mstable.org>
discussions-to: https://forum.mstable.org/t/mip-3-add-cache-to-reduce-gas-costs/227
created: 2020-10-27
---

## Simple Summary

<!--"If you can't explain it simply, you don't understand it well enough." Simply describe the outcome the proposed changes intends to achieve. This should be non-technical and accessible to a casual community member.-->

Depositing and withdrawing from lending markets (Compound, Aave) constitutes
60-90% of the gas cost of a given transaction. This MIP proposes to implement a
cache to reduce frequency of interactions with the lending pools, thus reducing gas
costs in MINT, SWAP and REDEEM by 60-90% for the majority of users.

## Abstract

<!--A short (~200 word) description of the proposed change, the abstract should clearly describe the proposed change. This is what *will* be done if the MIP is implemented, not *why* it should be done or *how* it will be done. If the MIP proposes deploying a new contract, write, "we propose to deploy a new contract that will do x".-->

We propose upgrading the `Masset.sol` contract, allowing it to track and retain a percentage of
each collateral in a "cache". This cache will reside in the pre-existing `PlatformIntegration` for
gas optimisation purposes. Only if necessary will the `Masset` then deposit or withdraw from
the lending markets. When a deposit or withdrawal happens, the cache will reset to the ideal target
weight, determined by a governance parameter. Subsequently, the `BasketManager.sol` will be upgraded
to use the cache data during normal interest collection.

## Motivation

<!--This is the problem statement. This is the *why* of the MIP. It should clearly explain *why* the current state of the protocol is inadequate.  It is critical that you explain *why* the change is needed, if the MIP proposes changing how something is calculated, you must address *why* the current calculation is innaccurate or wrong. This is not the place to describe how the MIP will address the issue!-->

Since mStable launched in early June, gas costs have increased drastically. This increase combined with interaction
with lending markets Compound & Aave makes MINT, SWAP and REDEEM much more expensive than feasible. This massive
gas cost incurred during lending market interaction is avoidable and not necessary to do for every transaction.
An intuitive concern with caching could be that it produces less yield for SAVE, but in fact it will likely produce a higher
yield due to having more liquid bAssets available to swap/redeem for cheap, thus increasing total volume in the system.
This proposed cache is analogous to a computers memory cache - "an auxiliary memory from which high-speed retrieval is possible.".
In our case, memory = liquidity pool && high speed = low gas.

## Specification

<!--The specification should describe the syntax and semantics of any new feature, there are five sections
1. Overview
2. Rationale
3. Technical Specification
4. Test Cases
5. Configurable Values
-->

### Overview

<!--This is a high level overview of *how* the MIP will solve the problem. The overview should clearly describe how the new feature will be implemented.-->

At the high level, there will now be a % of bAsset liquidity retained in the corresponding `PlatformIntegration` (a.k.a. _"the Cache"_).
Deposits and withdrawals of a given bAsset will primarily interact with this Cache, unless a withdrawal will
push the cache past 0 units, or a deposit will push the cache past `X%` of total mAsset supply. At this point, an amount will be
deposited/withdrawn from the lending market to reset the cache to `X/2%` of total supply.

The solution will comprise of three parts:

**1 - Upgrade to `Masset.sol`**

Configurable property: Max Cache % (hereafter `MAX`)

A generic rule will be in place for deposits (MINT, SWAP in) and withdrawals (SWAP out, REDEEM).

The rule is as follows: if a deposit pushes a bAsset balance > `MAX * totalSupply`, then deposit
bAsset into the lending market, in order to bring the bAsset balance back to `MAX/2 * totalSupply`.

The inverse is true for withdrawals: if there is sufficient liquidity to withdraw (goes beyond 0), then
withdraw enough bAsset from the lending market to a) pay out to user and b) reset bAsset balance back to `MAX/2 * totalSupply`.

Pseudocode for a deposit here:

```typescript

// Before
uint totalSupply = 100000000; // 100%
uint bAssetBalance = 600000; // 6%
var MAX = 0.07; // 7%

// Deposit
uint newDeposit = 500000; // 5%

uint newBalance = bAssetBalance + newDeposit; // 11%
if(newBalance > MAX*totalSupply) {
  uint overWeight = newBalance - (MAX*totalSupply/2);
  depositToLendingMarket(overWeight);
}

```

Pseudocode for a withdrawal here:

```typescript

// Before
uint totalSupply = 100000000; // 100%
uint bAssetBalance = 200000; // 2%
var MAX = 0.07; // 7%

// Deposit
uint withdrawal = 500000; // 5%

if(withdrawal > bAssetBalance){
  uint ideal = (MAX*totalSupply/2);
  uint mustWithdraw = ideal + (withdrawal - bAssetBalance);
  withdrawFromLendingMarket(mustWithdraw);
}

```

**2 - Upgrade to each `PlatformIntegration`**

New function: `withdrawRaw` allows the `Masset` or `BasketManager` to withdraw bAssets
directly from the contract.

New function: `withdraw` that accepts an `amount` and a `totalAmount`. The `totalAmount` is withdrawn
from the lending protocol before sending the `amount` back to the recipient, keeping `totalAmount`-`amount` in
the cache.

Move of responsibility for accounting during a given deposit to the `Masset.sol`. Previously
when calling `deposit`, the call would fail if there was insufficient liquidity - now that there is
a large amount of bAsset held in the cache, it's unlikely to fail under the same circumstances (i.e.
not having just received sufficient funds). The `Masset.sol` now has checks to ensure it is sending
sufficient capital.

**3 - Upgrade to `BasketManager.sol`**

Currently the interest collection mechanism reads balances from Aave/Compound for each bAsset,
before minting a corresponding amount of mUSD based on the accrued interest. The BasketManager
must be upgraded now to read both `bAsset.balanceOf(integration)` as well as the balance from lending
market. This is a trivial change.

### Rationale

There were a few technical considerations taken into account before coming up with the final design.

**Cache size: total supply % vs per bAsset %**

When choosing what to base the cache size on, there were two clear options: a % of total supply of mAsset,
or a % of each bAsset. The % of each bAsset posed some problems: consider that a bAsset has only a few thousand
units of liquidity - there is no point in depositing this to a lending pool. Additionally, if a bAsset has 50m in
liquidity, it's unlikely that a high % of this should be in the cache, as it does not support the thesis of reducing gas
costs for small orders.

If the path of a per bAsset % is one to go down, there would also need to be a minimum cache size in terms of units,
where `max cache = min(X% of bAsset, Yk units)`.

**Rebalancing: automated vs manual**

It's possible to completely remove the lending market interactions from the forging process, and transfer the
responsibility over to a publicly callable, external function. This function could be called regularly to rebalance the pools
to their optimal cache size. With that in mind, and to reduce the manual overhead of the system, we opted to keeping as is.

**Lending market vs masset upgrade**

There were two places to technically implement the cache - either in Masset.sol or in the platform integration contracts. I believe
doing so here removes both technical overhead from development and reduces gas costs for the majority of calls.

<!--This is where you explain the reasoning behind how you propose to solve the problem. Why did you propose to implement the change in this way, what were the considerations and trade-offs. The rationale fleshes out what motivated the design and why particular design decisions were made. It should describe alternate designs that were considered and related work. The rationale may also provide evidence of consensus within the community, and should discuss important objections or concerns raised during discussion.-->

### Technical Specification

<!--The technical specification should outline the public API of the changes proposed. That is, changes to any of the interfaces mStable currently exposes or the creations of new ones.-->

N/A

### Configurable Values (Via MCCP)

<!--Please list all values configurable via MCCP under this implementation.-->

Configurable value: Max Cache %

This value will determine the maximum amount of each bAsset that should be in the cache,
and is a percentage of total supply of the mAsset. This can be configured by governance.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
