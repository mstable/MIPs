---
mip: 7
title: Buyback & Make
status: Proposed
author: Alex Scott <alex@mstable.org>
discussions-to:
created: 2021-02-07
---

## Simple Summary

<!--"If you can't explain it simply, you don't understand it well enough." Simply describe the outcome the proposed changes intends to achieve. This should be non-technical and accessible to a casual community member.-->

Members of the mStable protocolDAO propose that MTA's long term utility and tokenomics can be improved by implementing a buyback-and-make strategy driven by an MTA/ETH liquidity pool. In future, this pool could also be used in mStable's re-collateralisation mechanism (in the event of an asset de-pegging) or as an incentivisation tool.

## Abstract

<!--A short (~200 word) description of the proposed change, the abstract should clearly describe the proposed change. This is what *will* be done if the MIP is implemented, not *why* it should be done or *how* it will be done. If the MIP proposes deploying a new contract, write, "we propose to deploy a new contract that will do x".-->

A new smart contract will be deployed that converts a portion of mAsset fees into ETH, and deposits into a Balancer MTA/ETH pool. A percentage of protocol fees that would normally go to savers is proposed to be be diverted into this pool, which will serve as a source of demand for MTA already in circulation.

The Protocol DAO proposes that the pool have the following specifications:

- Private Balancer pool, with the protocol as the only valid liquidity provider. Its utility will be voted on in future governance polls.
- MTA/ETH, initially at a 99/1 and sliding to 80/20 over time. Feedback is sought on the ideal ratio to maintain.
- Fees generated from mStable's platform will be converted into ETH and sent to the pool. Conversion is required as mStable organically generates fees in USD stablecoins and mUSD.
- Pool swap fee - 3%
- As ETH builds up in the pool, it will buy MTA to return it back to the correct MTA/ETH composition.

This pool is proposed, created and would be maintained by by the mStable protocolDAO and its signers. Consequently, the mStable Genesis team will not have control over how this buyback-and-make strategy is implemented or improved upon over time. Any significant changes here could be proposed and voted on by Meta Governors and ratified by the mStable protocolDAO.

## Motivation

<!--This is the problem statement. This is the *why* of the MIP. It should clearly explain *why* the current state of the protocol is inadequate.  It is critical that you explain *why* the change is needed, if the MIP proposes changing how something is calculated, you must address *why* the current calculation is innaccurate or wrong. This is not the place to describe how the MIP will address the issue!-->

This proposal creates long term value for the protocol, through bolstering of MTA liquidity and the [reflexivity][1] of capturing system value. Buyback & make provides the following key benefits:

- Immediate effect on token liquidity and demand. This causes both immediate and sustainable demand for the system token. As opposed to simply burning the token and taking it off the market, this value can be re-cycled and used as a liquidity pool to support trades through Balancer
- In addition to the immediate effects on liquidity, the value can be used to fund mAsset re-collateralisation for example. This is a decision that could be made by MTA governors as the pool grows in size.
- The reflexivity caused by an increased demand for the token causes a positive feedback loop between other incentives across the protocol, for example providing more powerful rewards for EARN pool participants
- The capturing, storing and utilisation of fees provides long term system value, as opposed to only providing immediate incentives for SAVE participants, which has little lasting impact

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

1. Private Balancer pool of MTA/ETH is created, with a high swap fee (~3%) and the protocol as the only valid liquidity provider
1. A `savingsRate` variable is set to determine which % of protocol fees should be diverted from SAVE to the pool (a.k.a "revenue recipient")
1. A smart contract implementing `IRevenueRecipient` interface is created, which receives mAssets and converts them into ETH before depositing them into this pool
1. The `IRevenueRecipient` contract is added to the `SavingsManager` and now fees generated from mStable's platform will be intermittently converted into ETH and sent to the pool. Conversion is required as mStable organically generates fees in USD stablecoins and mUSD.

### Rationale

<!--This is where you explain the reasoning behind how you propose to solve the problem. Why did you propose to implement the change in this way, what were the considerations and trade-offs. The rationale fleshes out what motivated the design and why particular design decisions were made. It should describe alternate designs that were considered and related work. The rationale may also provide evidence of consensus within the community, and should discuss important objections or concerns raised during discussion.-->

Most of this architecture either currently exists, or is trivial to create. For example point 2 - this `savingsRate` already exists and functions in the current system, but is not yet turned on. The system already has the ability to deposit to `IRevenueRecipient`. The only new code that needs implemented is the `IRevenueRecipient` contract and as such the design questions and trade-offs are noted for this.

Depositing in single sided liquidity vs equal distribution:

Pool configuration on chain vs off chain:

Pool configuration: composition & swap fees

## Technical Specification

<!--The technical specification should outline the public API of the changes proposed. That is, changes to any of the interfaces mStable currently exposes or the creations of new ones.-->

```typescript
interface IRevenueRecipient {
    function notifyRedistributionAmount(address _mAsset, uint256 _amount) external;
}
```

### Test Cases

### Configurable Values (Via MCCP)

<!--Please list all values configurable via MCCP under this implementation.-->

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

[1]: https://www.investopedia.com/terms/r/reflexivity.asp
