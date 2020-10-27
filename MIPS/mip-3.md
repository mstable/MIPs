---
mip: 3
title: Add a cache to reduce gas costs
status: Proposed
author: Alex Scott <alex@mstable.org>
discussions-to: https://forum.mstable.org/
created: 2020-10-27
---

## Simple Summary

<!--"If you can't explain it simply, you don't understand it well enough." Simply describe the outcome the proposed changes intends to achieve. This should be non-technical and accessible to a casual community member.-->

Depositing and withdrawing from lending markets (Compound, Aave) constitutes
70-90% of the gas cost of a given transaction. This MIP proposes to implement a
cache to reduce frequency of interactions with the lending pools.

## Abstract

<!--A short (~200 word) description of the proposed change, the abstract should clearly describe the proposed change. This is what *will* be done if the MIP is implemented, not *why* it should be done or *how* it will be done. If the MIP proposes deploying a new contract, write, "we propose to deploy a new contract that will do x".-->

Create a `Liquidator` contract that sells the reward tokens approved in both
Compound and Aave integrations. This will allow accrued rewards tokens to be sold on DEXs and the
value returned to SAVE. This will bolster the SAVE APY and realised the value of
accrued rewards.

The protocol earns rewards from different platforms for lending stablecoins.
To dat, the protocol has earned ~470 \$COMP tokens for lending DAI and USDC
and it is expected that the protocol will earn tokens from other platforms.
This MIP offers an automated generic way to liquidate accrued tokens and to
return this value to the protocol. This will bolster the SAVE APY.

## Motivation

<!--This is the problem statement. This is the *why* of the MIP. It should clearly explain *why* the current state of the protocol is inadequate.  It is critical that you explain *why* the change is needed, if the MIP proposes changing how something is calculated, you must address *why* the current calculation is innaccurate or wrong. This is not the place to describe how the MIP will address the issue!-->

The mStable protocol lends stablecoins to lending platforms and derives a
return for depositors based on the Supply APY of the Platform. In addition to
Supply APY rates many lending platforms offer liquidity providers rewards in
the form of tokens. These tokens are tradable on DEXs and have value and
provide an additional yield for liquidity provision.

The mStable protocol deposits DAI and USDC to Compound and has been accruing
`$COMP` tokens as a result. These tokens are valuable but the current protocol
has no way to realise the value from accrued rewards. As such these tokens
remain on a contract and the value cannot be liquidated.

For lending DAI and USDC to Compound the protocol has accrued $COMP tokens as
rewards. The $COMP that has been accrued on the `CompoundIntegration` with a
[balance of ~470 \$COMP][1] equivalent to \$72k at the time of writing. This
value should be liquidated and distrubted to SAVE. The protocol should automate
this selling to support the push towards decentralisation.

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

This MIP creates a generic liquidiator that allows accrued rewards tokens to be retrieved
from a given `integration` (e.g. CompoundIntegration), and sold for mUSD which is then
sent to the SavingsManager.

Liquidations are triggered once by week by any community member through an external function.

**Flow**

1. Liquidator sells `$COMP` for `USDC` (or other) on Uniswap once per week (up to trancheAmount).
1. Sell `USDC` for `mUSD` on Curve and send to SavingsManager
1. SavingsManager **streams** mUSD to SAVE, second by second over the course of a week

### Rationale

<!--This is where you explain the reasoning behind how you propose to solve the problem. Why did you propose to implement the change in this way, what were the considerations and trade-offs. The rationale fleshes out what motivated the design and why particular design decisions were made. It should describe alternate designs that were considered and related work. The rationale may also provide evidence of consensus within the community, and should discuss important objections or concerns raised during discussion.-->

There final architecture choice increases very little gas in the system -
only causing 1600 gas (2x SLOAD) to a SAVE deposit. No gas costs are seen for
general mint/swap/redemption. Any gas cost is incurred once a week when the liquidation
is triggered.

The streaming of the mUSD to SAVE also achieves a gradual
release of the realised mUSD over the course of a full week to SAVE, avoiding the scenario
in which malicious actors could trigger the liquidation and jump into the SAVE contract
to immediately benefit.

Capitalising on the new Curve 3Pool, it is now optimal to sell COMP for a given bAsset on
Uniswap (e.g. DAI or USDC), then immediately sell that bAsset on Curve for mUSD.

There were a number of previous architecture ideas that turned out to be sub optimal, including
intermittent collection from the Liquidator, and intermittent airdropping.

### Technical Specification

<!--The technical specification should outline the public API of the changes proposed. That is, changes to any of the interfaces mStable currently exposes or the creations of new ones.-->

A `Liquidator.sol` contract will be created that will sell `Token A` for `Token B` on a DEX.
Initially Uniswap and Curve will be supported but Balancer, 1inch, UniSwap and
other integrations may be added. In the short term the contract will be
upgradable with a view to it becoming immutable.

Protocol contracts that hold reward tokens will give the Liquidator infinite
approval to spend the rewards tokens. The Liquidator will then begin selling
`Token A` once per week, for `Token B`, and then turning this `Token B` into mUSD.

#### Contract changes

**Liquidator.sol (NEW)**

Key functions:

```
    /**
    * @dev Create a liquidation
    * @param _integration The integration contract address from which to receive sellToken
    * @param _sellToken Token harvested from the integration contract
    * @param _bAsset The asset to buy on Uniswap
    * @param _curvePosition Position of the bAsset in Curves MetaPool
    * @param _uniswapPath The Uniswap path as an array of addresses e.g. [COMP, WETH, DAI]
    * @param _trancheAmount The amount of bAsset units to buy in each weekly tranche
    */
    function createLiquidation(
        address _integration,
        address _sellToken,
        address _bAsset,
        int128 _curvePosition,
        address[] calldata _uniswapPath,
        uint256 _trancheAmount
    )

    /**
    * @dev Triggers a liquidation, flow (once per week):
    *    - Sells $COMP for $USDC (or other) on Uniswap (up to trancheAmount)
    *    - Sell USDC for mUSD on Curve
    *    - Send to SavingsManager
    * @param _integration Integration for which to trigger liquidation
    */
    function triggerLiquidation(address _integration)
        external
```

**CompoundIntegration (PROXY UPGRADE)**

```
    /**
     * @dev Approves Liquidator to spend COMP (0xc00e94Cb662C3520282E6f5717214004A7f26888)
     */
    function approveRewardToken()
        external
        onlyGovernor
```

**SavingsManager (MODULE UPGRADE)**

Deposited mUSD from the Liquidator is streamed to the SAVE contract over the course of a full week.
This means that as deposits to SAVE happen, they realise some of the value.

```
    /**
     * @dev Allows the liquidator to deposit proceeds from iquidated gov tokens.
     * Transfers proceeds on a second by second basis to the Savings Contract over 1 week.
     * @param _mAsset The mAsset to transfer and distribute
     * @param _liquidated Units of mAsset to distribute
     */
    function depositLiquidation(address _mAsset, uint256 _liquidated)
        external
        onlyLiquidator
```

### Configurable Values (Via MCCP)

<!--Please list all values configurable via MCCP under this implementation.-->

- TrancheAmount (max units of mUSD to purchase per week - useful for starting period)
- BuyAsset (must be some bAsset of USDC, USDT or DAI since that is the Curve 3 pool)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

[1]: https://etherscan.io/tokenholdings?a=0xd55684f4369040c12262949ff78299f2bc9db735
