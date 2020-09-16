---
mip: <to be assigned>
title: Add a liquidator to sell reward tokens
status: WIP
author: George Ornbo <george@mstable.org>
discussions-to: https://forum.mstable.org/t/add-liquidator-proposal-to-liquidate-comp-rewards/81
created: 2020-09-16 
---

<!--You can leave these HTML comments in your merged MIP and delete the visible duplicate text guides, they will not appear and may be helpful to refer to if you edit it again. This is the suggested template for new MIPs. Note that an MIP number will be assigned by an editor. When opening a pull request to submit your MIP, please use an abbreviated title in the filename, `mip-draft_title_abbrev.md`. The title should be 44 characters or less.-->

## Simple Summary
<!--"If you can't explain it simply, you don't understand it well enough." Simply describe the outcome the proposed changes intends to achieve. This should be non-technical and accessible to a casual community member.-->
This MIP proposes a liquidation mechanism for assets owned by the protocol.
Through the liquidator mechanism tokens may be liquidated and the value of
these tokens may be realised by the protocol. 

## Abstract
<!--A short (~200 word) description of the proposed change, the abstract should clearly describe the proposed change. This is what *will* be done if the MIP is implemented, not *why* it should be done or *how* it will be done. If the MIP proposes deploying a new contract, write, "we propose to deploy a new contract that will do x".-->
Create a `Liquidator` contract that may be called from other mStable protocol
contracts. This will allow accrued rewards tokens to be sold on DEXs and the
value returned to SAVE. This will bolster the SAVE APY and realised the value of
accrued rewards.  

The protocol earns rewards from different platforms for lending stablecoins.
To dat, the protocol has earned ~470 $COMP tokens for lending DAI and USDC
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
$COMP tokens as a result. These tokens are valuable but the current protocol
has no way to realise the value from accrued rewards. As such these tokens
remain on a contract and the value cannot be liquidated.  

For lending DAI and USDC to Compound the protocol has accrued $COMP tokens as
rewards. The $COMP that has been accrued on the `CompoundIntegration` with a
[balance of ~470 $COMP][1] equivalent to $72k at the time of writing.  This
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
This MIP creates a generic liquidiator that allows accrued rewards tokens to be
swapped on a DEX. The first use case for the liquidator will be to automate the
selling of $COMP on the open market to bolster the SAVE APY. The $COMP tokens
will be exchanged for cDAI and returned to the `CompoundIntegration.sol`
contract. 

### Rationale
<!--This is where you explain the reasoning behind how you propose to solve the problem. Why did you propose to implement the change in this way, what were the considerations and trade-offs. The rationale fleshes out what motivated the design and why particular design decisions were made. It should describe alternate designs that were considered and related work. The rationale may also provide evidence of consensus within the community, and should discuss important objections or concerns raised during discussion.-->
The rational for a liquidator is:

1. **Realise value**: The value of accrued rewards tokens should be liquidated and returned to SAVE to bolster APY.
2. **Automate Liquidation**: Rewards tokens should be liquidated in an automated manner. This is to support the transition to decentralisation and remove the requirement for any human intervention.  
3. **Feed liquidations back into the protocol** Luquidations should go back into the mStable protocol to help further improve APY through Swap Fees. 

Some thought was given to implementing more exotic Yield Farming strategies to
increase the APY further. Depositing to CREAM was considered as was depositing
to Balancer Pools or to Sake Pools. This was felt to be too risky and to
require active Fund Management to ensure good returns. 

As such an automated, predictable return is favoured by selling `Token A` for
`Token B` on the open market. 
 
Related work includes yearn.finance selling $CRV tokens on the open market. 

### Technical Specification
<!--The technical specification should outline the public API of the changes proposed. That is, changes to any of the interfaces mStable currently exposes or the creations of new ones.-->

A `Liquidator.sol` contract will be created that will sell `Token A` for `Token
B` on a DEX. Initially Balancer will be supported but 1inch, UniSwap and
other integrations may be added. In the short term the contract will be
upgradable with a view to it becoming immutable. 

Protocol contracts that hold reward tokens will give the Liquidator infinite
approval to spend the rewards tokens. The Liquidator will then begin selling
`Token A` and will return `Token B` to originating contract.

An initial use case is to sell the $COMP available on the
`CompoundIntegration.sol` contract for $cDAI. The `CompoundIntegrator.sol`
contract will grant the `Liquidator.sol` contract infinite approval on the
$COMP that it holds. The Liquidator will begin selling the $COMP at a drip rate
and will return $cDAI to the `CompoundIntegrator.sol` contract. 

To prevent people gaming Liquidations and depositing large amounts around a
liquidation to benefit from the returns liquidations will be smoothed over time
and separated into two steps.

The first is for the Liquidator to sell a proportion of the amount it holds
when the `triggerLiquidation` function is called. The `triggerLiquidation` is a
public function and may be called by anyone, but may only be called once in a
24 hour period. Based on the spot price for the asset the function will compute
a value between $1000 and $3000 and trigger a sale for this amount. After the
token has been swapped the token remains on the Liquidator contract.

The second step is for the Integration contract to call `collect()` on the
liquidator. This function will transfer a proportion of the tokens from the
Liquidator contract to the Integration contract. At this point the token is on
the Integration contract and earning Supply APY.

The following psueudo code is a proposal for how `collect()` function should
distribute bought tokens to the Integration contract when called. 

```
contractBal = buyAsset.balanceOf(address(this)) 
spotPrice = exchange.getSpotPriceFor(buyAsset)
value = contactBal * spotPrice
// If the value is less than 1000 transfer everything
if value < 1000
  buyAsset.transfer(contractBal, integration)
// If the value is gt 1000 transfer a percentage of the tokens as set by governance
else
  amountToSend = contractBal * collectPercentage
  buyAsset.transfer(amountToSend, integration)
```

It is proposed that the `collect()` function is called at a specific time
interval. The initial proposal is one hour. 
  

**Interface**

```
pragma solidity 0.5.16;

interface ILiquidations {
    struct Liquidation {
        address basset;
        address integration;
        address rewardToken;
        uint    amount;
        uint    collectDrip;
        bool    paused;
    }

    // Views
    function getLiquidation(address _bAsset) external view returns (Liquidation memory l);

    // Restricted to the `integrationContract` given in addLiquidation
    function collect() external;

    // Callable by anyone to trigger a selling event 
    function triggerLiquidation(address _bAsset) public;

    // Governor only
    function addLiquidation(address _bAsset, address _integration, uint _amount ) external;
    function removeLiquidation(address _bAsset) external;
    function pauseLiquidation(address _bAsset) external;
    function setCollectDrip(address _bAsset) external;
}
```
**Events**

* event LiquidationAdded(address indexed bAsset);
* event LiquidationRemoved(address indexed bAsset);
* event LiquidationPaused(address indexed bAsset);
* event LiquidationTriggered(address indexed bAsset);
* event LiquidationCollected(address indexed bAsset);

### Compound Integration Contract
---
The `CompoundIntegration.sol` will be amend the `deposit` and `withdrawal` function to call `collect(_bAsset)` on the Liquidator contract. No interface changes are needed. 

### Test Cases
<!--Test cases for an implementation are mandatory for MIPs but can be included with the implementation..-->

Given the following preconditions:

- A bAsset exists and is earning a reward token on an integration contract
- A governor issues a transaction to give the Liquidator infinite approval on the reward token.

***

When

- A liquidition is created

Then

- ✅ It successfully adds a liquidation
- ✅ It transfers the Reward Token from the Integration contract to the Liquidation contract.

***

Given the following preconditions:

- The Liquidator contract holds some rewards tokens for a bAsset

***

When

- The `triggerLiquidation()` function is called 

Then

- ✅ It successfully sells an amount of the sell token
- ✅ It receives the buy token

***

When

- The `collect()` function is called by the Integration contract

Then

- ✅ It transfers some buy tokens from the Liquidator to the Integration contract

***

When

- The `collect()` function is called by a contract other than the Integration contract.

Then

- ❌ it fails and reverts because the caller is not the Integration contract

### Configurable Values (Via MCCP)
<!--Please list all values configurable via MCCP under this implementation.-->
None

## Copyright
Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

[1]: https://etherscan.io/tokenholdings?a=0xd55684f4369040c12262949ff78299f2bc9db735
[2]: https://1inch.exchange
