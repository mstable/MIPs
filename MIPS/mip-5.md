---
mip: 5
title: Tokenise mUSD SAVE, enhance capital efficiency and add deposit box
status: Approved
author: Alex Scott <alex@mstable.org>
discussions-to: https://forum.mstable.org/t/mip-5-tokenise-musd-save-enhance-capital-efficiency-and-add-deposit-box/275
created: 2020-12-04
---

## Simple Summary

<!--"If you can't explain it simply, you don't understand it well enough." Simply describe the outcome the proposed changes intends to achieve. This should be non-technical and accessible to a casual community member.-->

mStable’s SAVE remains one of the most accessible, reliable and high-yielding
products in DeFi. Elements of it’s design however limit the ability for it to
be integrated across the broader DeFi ecosystem.

This MIP proposes that it be reconfigured to enhance the capital efficiency it
offers to SAVE depositors and enable it to more easily be integrated into other
DeFi, and CeFi, platforms. Additionally, under-utilised capital stored in SAVE
can be put to work to contribute additionally to yield.

## Abstract

<!--A short (~200 word) description of the proposed change, the abstract should clearly describe the proposed change. This is what *will* be done if the MIP is implemented, not *why* it should be done or *how* it will be done. If the MIP proposes deploying a new contract, write, "we propose to deploy a new contract that will do x".-->

We propose adding composability to mStable’s SAVE product to enhance its functionality,
improve the potential capital efficiency for depositors in SAVE and increase SAVE’s
potential integration across the DeFi ecosystem.

This proposal comes in 3 main parts:

1. Tokenising the "Savings Credit", creating a `imUSD` token that represents the yield accruing `mUSD` and can be transferred and used as collateral in DeFi
   - Core behaviour will be optimised in terms of gas usage
2. Enhancing capital efficiency by depositing `X%` of SAVE deposits elsewhere in the DeFi ecosystem (initially yEarn `mUSD` vault)
3. Providing a `imUSD` deposit box, a place where long term savers can store their `imUSD` and earn `MTA`
   - This is aimed at supporting the migration of funds, and ensuring that recipients of system yield have a say in how it is distributed
   - To ensure long term alignment, earnings will be heavily boosted for `MTA` stakers, and lockups will apply

## Motivation

<!--This is the problem statement. This is the *why* of the MIP. It should clearly explain *why* the current state of the protocol is inadequate.  It is critical that you explain *why* the change is needed, if the MIP proposes changing how something is calculated, you must address *why* the current calculation is innaccurate or wrong. This is not the place to describe how the MIP will address the issue!-->

The provision of a token representing a liquidity provider or lender’s capital makes that capital composable. The token can be used as proof of the deposit and therefore as collateral on other platforms increasing the potential returns earned by that capital. This would increase the efficiency of capital allocated to SAVE and, all else being equal, should increase demand for the product. Composability allows collateral on one DeFi platform to be used on another which also enhances the original platforms integration across the DeFi ecosystem.

In terms of enhancing capital efficiency, currently all SAVE deposits are sitting idle in the contract and are not being utilised to their full extent. mUSD is a stablecoin that can be used throughout the DeFi ecosystem, providing value and ultimately generating yield and so makes sense for it to be recycled.

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

**1 - Tokenising SAVE**

The MIP will simply create a savings contract that tokenises the savings credit. In reality, this is a trivial change, and just involves utilising
existing ERC20 standards. Instead of simply having internal accounting for the savings credit, we can expose it via public functions, and allow it to be
transferred.

This provides an opportunity to revisit gas costs, and public interfaces, introducing methods like `redeemUnderlying`, and fixing a few small issues
that were present in the original save contract that hindered composability.

**2 - Enhancing capital efficiency**

The upgraded savings contract will allow for a certain % of funds to be invested or utilised in a third party protocol, in order to generate additional
yield for savers. This will come at no additional gas cost to depositors, as it will involve using a `poke` function to deposit, withdraw and accrue interest
from the third party platform based on some internal rules. Initially, the funds will be deposited into a [yEarn][1] mUSD yVault. This management will be outsourced to a separate contract for accounting and upgradability-minimisation purposes.

**3 - imUSD deposit box, with boost for stakers**

Taking inspiration from [Curve-Dao][2], the deposit box will be an upgraded `StakingRewards` contract, with baked in incentives providing a 'boost' for
participants who are also actively staking in [mStable-Staking][3]. Actors who are not staking will receive a base layer rewards, with up to 5x boost
for those who are actively staking at the upper end of the threshold. The specific vMTA requirements will vary depending on the total amount of imUSD and vMTA
staked. A lockup will be implemented, forcing users to wait up to 6 months after calling the `claim` function, before their rewards are unlocked and transferred to them.

### Rationale

<!--This is where you explain the reasoning behind how you propose to solve the problem. Why did you propose to implement the change in this way, what were the considerations and trade-offs. The rationale fleshes out what motivated the design and why particular design decisions were made. It should describe alternate designs that were considered and related work. The rationale may also provide evidence of consensus within the community, and should discuss important objections or concerns raised during discussion.-->

**Gas efficiency**

The token creation is fairly straight forward, although there are a number of optimisations that can be made to the way interest is collected by the savings contract. Notably, there is a `totalSavings` prop that is not actually useful and could be removed to reduce 5k on each deposit/withdrawal. Instead, the `creditBalances` and `exchangeRate` can be used to determine what affect new deposits have on the `exchangeRate`.

**Capital efficiency**

Choices between managing the capital and utilising a third party capital manager (i.e. yEarn). Having a proven and efficient third party to operate this
section of the contract was a clear optimisation vs having to deal with the additional complexity with, for example, a Curve pool that provides incentives in CRV.

In terms of making this interaction generic internally, there were two choices as to where this could take place - either in the imUSD contract, or in a specified manager contract. Having a single replaceable manager contract with a generic interface will allow for migration of funds from one 'strategy' to the next when the time comes, and reduces the urgency for making upgrades to the core imUSD contract.

**Deposit box**

There was a large decision in either having MTA rewards accrue to imUSD holders, or having a seperate deposit box from which to earn the yield. In order to keep the `transfer` function cost of the imUSD token to a minimum, and to facilitate the boosted and locked up rewards, it was a major optimisation to move this to a seperate contract.

### Technical Specification

<!--The technical specification should outline the public API of the changes proposed. That is, changes to any of the interfaces mStable currently exposes or the creations of new ones.-->

#### imUSD

**Ensures backwards compatibility** by maintaining all functions from the [previous SAVE interface][4].

Adds additional external functions to the Interface:

```typescript
interface ISavingsContractV2 {

    // DEPRECATED but still backwards compatible
    function redeem(uint256 _amount) external returns (uint256 massetReturned);
    function creditBalances(address) external view returns (uint256); // V1 & V2 (use balanceOf)

    // --------------------------------------------

    function depositInterest(uint256 _amount) external; // V1 & V2

    function depositSavings(uint256 _amount) external returns (uint256 creditsIssued); // V1 & V2
    function depositSavings(uint256 _amount, address _beneficiary) external returns (uint256 creditsIssued); // V2

    function redeemCredits(uint256 _amount) external returns (uint256 underlyingReturned); // V2
    function redeemUnderlying(uint256 _amount) external returns (uint256 creditsBurned); // V2

    function exchangeRate() external view returns (uint256); // V1 & V2

    function balanceOfUnderlying(address _user) external view returns (uint256 balance); // V2

    function underlyingToCredits(uint256 _credits) external view returns (uint256 underlying); // V2
    function creditsToUnderlying(uint256 _underlying) external view returns (uint256 credits); // V2

}
```

#### Deposit box

```typescript
interface IBoostedVaultWithLockup {

    /**
     * @dev Stakes a given amount of the StakingToken for the sender
     * @param _amount Units of StakingToken
     */
    function stake(uint256 _amount) external;

    /**
     * @dev Stakes a given amount of the StakingToken for a given beneficiary
     * @param _beneficiary Staked tokens are credited to this address
     * @param _amount      Units of StakingToken
     */
    function stake(address _beneficiary, uint256 _amount) external;

    /**
     * @dev Withdraws stake from pool and claims any unlocked rewards.
     * Note, this function is costly - the args for _claimRewards
     * should be determined off chain and then passed to other fn
     */
    function exit() external;

    /**
     * @dev Withdraws stake from pool and claims any unlocked rewards.
     * @param _first    Index of the first array element to claim
     * @param _last     Index of the last array element to claim
     */
    function exit(uint256 _first, uint256 _last) external;

    /**
     * @dev Withdraws given stake amount from the pool
     * @param _amount Units of the staked token to withdraw
     */
    function withdraw(uint256 _amount) external;

    /**
     * @dev Claims only the tokens that have been immediately unlocked, not including
     * those that are in the lockers.
     */
    function claimReward() external;

    /**
     * @dev Claims all unlocked rewards for sender.
     * Note, this function is costly - the args for _claimRewards
     * should be determined off chain and then passed to other fn
     */
    function claimRewards() external;

    /**
     * @dev Claims all unlocked rewards for sender. Both immediately unlocked
     * rewards and also locked rewards past their time lock.
     * @param _first    Index of the first array element to claim
     * @param _last     Index of the last array element to claim
     */
    function claimRewards(uint256 _first, uint256 _last) external;

    /**
     * @dev Pokes a given account to reset the boost
     */
    function pokeBoost(address _account) external;

    /**
     * @dev Gets the RewardsToken
     */
    function getRewardToken() external view returns (IERC20);

    /**
     * @dev Gets the last applicable timestamp for this reward period
     */
    function lastTimeRewardApplicable() external view returns (uint256);

    /**
     * @dev Calculates the amount of unclaimed rewards per token since last update,
     * and sums with stored to give the new cumulative reward per token
     * @return 'Reward' per staked token
     */
    function rewardPerToken() external view returns (uint256);

    /**
     * @dev Returned the units of IMMEDIATELY claimable rewards a user has to receive. Note - this
     * does NOT include the majority of rewards which will be locked up.
     * @param _account User address
     * @return Total reward amount earned
     */
    function earned(address _account) external view  returns (uint256);

    /**
     * @dev Calculates all unclaimed reward data, finding both immediately unlocked rewards
     * and those that have passed their time lock.
     * @param _account User address
     * @return amount Total units of unclaimed rewards
     * @return first Index of the first userReward that has unlocked
     * @return last Index of the last userReward that has unlocked
     */
    function unclaimedRewards(address _account) external view returns (uint256 amount, uint256 first, uint256 last);
}
```

#### Migration

Funds in SAVE will require a migration from v1 to v2 in order to continue to accrue interest.
This will be primarily supported on the [mStable-app][5] but also incentivised with a higher APY
and the free option of storing the imUSD up in the deposit box and earning MTA.

### Configurable Values (Via MCCP)

<!--Please list all values configurable via MCCP under this implementation.-->

#### imUSD

- Percentage of funds deposited into the third party platform
- Destination of deposited funds, i.e. choice of third party platform

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

[1]: https://yearn.finance
[2]: https://github.com/curvefi/curve-dao-contracts
[3]: https://governance.mstable.org/#/stake
[4]: https://github.com/mstable/mStable-contracts/blob/master/contracts/interfaces/ISavingsContract.sol
[5]: https://app.mstable.org/#/save
