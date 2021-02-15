---
mip: 8
title: Buyback & Make
status: Proposed
author: Alex Scott <alex@mstable.org>
discussions-to:
created: 2021-02-07
---

## Simple Summary

<!--"If you can't explain it simply, you don't understand it well enough." Simply describe the outcome the proposed changes intends to achieve. This should be non-technical and accessible to a casual community member.-->

Members of the mStable protocolDAO propose that MTA's long term utility and tokenomics can be improved by implementing a buyback-and-make strategy driven by an MTA/ETH/mAsset liquidity pool. In future, this pool could also be used in mStable's re-collateralisation mechanism (in the event of an asset de-pegging) or as an incentivisation tool.

## Abstract

<!--A short (~200 word) description of the proposed change, the abstract should clearly describe the proposed change. This is what *will* be done if the MIP is implemented, not *why* it should be done or *how* it will be done. If the MIP proposes deploying a new contract, write, "we propose to deploy a new contract that will do x".-->

A new smart contract will be deployed that deposits a portion of mAsset into a Balancer MTA/ETH/mAsset pool. A percentage of protocol fees that would normally go to savers is proposed to be be diverted into this pool, which will serve as a source of demand for MTA already in circulation.

The Protocol DAO proposes that the pool have the following specifications:

- Private Balancer pool, with the protocol as the only valid liquidity provider. Its utility will be voted on in future governance polls.
- MTA/ETH/mUSD/mBTC, initially at a 50/10/20/20 and sliding to 78/20/1/1 over time as the pool matures. Feedback is sought on the ideal ratio to maintain longer term.
- Fees generated from mStable's platform will be deposited directly to the pool. Conversion is required as mStable organically generates fees in USD stablecoins and mUSD.
- Pool swap fee - 5%, sliding to 2% as the pool matures
- As mAssets build up in the pool, it will buy MTA to return it back to the correct MTA/ETH composition.

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

1. Private Balancer pool of MTA/ETH/mUSD/mBTC is created, with a high swap fee (~5%) and the protocol as the only valid liquidity provider
1. A `savingsRate` variable is set to determine which % of protocol fees should be diverted from SAVE to the pool (a.k.a "revenue recipient")
1. A smart contract implementing `IRevenueRecipient` interface is created, which receives mAssets and converts them into ETH before depositing them into this pool
1. The `IRevenueRecipient` contract is added to the `SavingsManager` and now fees generated from mStable's platform will be intermittently converted into ETH and sent to the pool. Conversion is required as mStable organically generates fees in mAsset terms.

### Rationale

<!--This is where you explain the reasoning behind how you propose to solve the problem. Why did you propose to implement the change in this way, what were the considerations and trade-offs. The rationale fleshes out what motivated the design and why particular design decisions were made. It should describe alternate designs that were considered and related work. The rationale may also provide evidence of consensus within the community, and should discuss important objections or concerns raised during discussion.-->

Most of this architecture either currently exists, or is trivial to create. For example point 2 - this `savingsRate` already exists and functions in the current system, but is not yet turned on. The system already has the ability to deposit to `IRevenueRecipient`. The only new code that needs implemented is the `IRevenueRecipient` contract and as such the design questions and trade-offs are noted for this.

**Pool configuration: composition & swap fees**
There are a few factors taken into consideration when choosing the composition and swap fees. Firstly, the pool should be primarily MTA, with a portion in ETH to give the pool utility, BAL rewards and exposure to ETH price during a bull market. Secondly, there must exist some method of converting system mAsset revenue into something desired by this pool - so it is logical to simply add the mAssets to the pool. Given that there will be very low liquidity at the beginning, it is important to have higher weightings for mAssets, and a high swap fee, so that the pool can maximise on the value from the deposited mAssets. If we were to have 78/20/1/1 from the beginning, with 1k TVL, depositing 10k mUSD would create inefficient arbitrage opportunities, and some value would be lost.

**Depositing in single sided liquidity vs equal distribution**
Depositing single sided liquidity in ETH or mAsset terms applies buy pressure to the rest of the pool. This will only have a positive effect on MTA, as the other assets are pegged to deeply liquid assets that will not be affected. Therefore, there is no upside to depositing in equal distribution.

**Pool configuration on chain vs off chain**
Managing a pools configuration over long term is not trivial. In order to introduce as little complexity as possible into the system, it is noted that the protocol is not the pool manager, but the only liquidity provider. They therefore have full custody of the assets, with normal MTA governors being able to decide the parameters of the system, and ultimately affecting what the funds will be used for in the future.

## Technical Specification

<!--The technical specification should outline the public API of the changes proposed. That is, changes to any of the interfaces mStable currently exposes or the creations of new ones.-->

```typescript
interface IRevenueRecipient {
    function notifyRedistributionAmount(address _mAsset, uint256 _amount) external;
}
```

New contract: `RevenueRecipient`

This contract will receive system revenue, verify the collection, and deposit into a given Balancer pool.

This builds on the existing logic in the [SavingsManager][2]`:

```typescript
    /**
     * @dev Redistributes the unallocated interest to the saved recipient, allowing
     * the siphoned assets to be used elsewhere in the system
     * @param _mAsset  mAsset to collect
     */
    function distributeUnallocatedInterest(address _mAsset)
        external
        onlyGovernance
    {
        IRevenueRecipient recipient = revenueRecipients[_mAsset];
        require(address(recipient) != address(0), "Must have valid recipient");

        IERC20 mAsset = IERC20(_mAsset);
        uint256 balance = mAsset.balanceOf(address(this));
        uint256 leftover_liq = _unstreamedRewards(_mAsset, StreamType.liquidator);
        uint256 leftover_yield = _unstreamedRewards(_mAsset, StreamType.yield);

        uint256 unallocated = balance.sub(leftover_liq).sub(leftover_yield);

        mAsset.approve(address(recipient), unallocated);
        recipient.notifyRedistributionAmount(_mAsset, unallocated);

        emit RevenueRedistributed(_mAsset, address(recipient), unallocated);
    }
```

### Configurable Values (Via MCCP)

<!--Please list all values configurable via MCCP under this implementation.-->

- savingsRate: Percentage of global system revenue (across all mAssets) that is diverted to savers. The remaining will be deposited to the RevenueRecipient
- Pool configuration: All pool settings are able to be determined as MCCPs

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

[1]: https://www.investopedia.com/terms/r/reflexivity.asp
[2]: https://etherscan.io/address/0x9781c4e9b9cc6ac18405891df20ad3566fb6b301
