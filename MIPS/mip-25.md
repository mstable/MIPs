---
mip: 25
title: Save Unwrapper
status: Implemented
author: Cesar Chavez (@doncesarts), Dimitri Golecko (@dimsome)
discussions-to: https://forum.mstable.org/t/mip-25-save-unwrapper/774
created: 2022-01-13
---

## Simple Summary

Currently, users of the protocol need to perform two transactions to deposit or withdraw from the savings product. This proposal outlines an upgrade to the contracts that would reduce the amount of transactions needed in order to ease any interaction with the save product and allow for easier integrations.

## Abstract

The contracts to deposit into save and subsequently vault allow for combinning 3 transactions into one single transaction. The SaveWrapper contract was used for this purpose. It allows minting of mUSD, depositing in save and the vault all in one transaction. However, this contract could not achive the same for withdrawals, since the underlying contract for the vault and save did not support such functions.

This proposal adds various Unwrapper functions to the exicsting save and vault contracts to facilitate the unwrapping of any given credit or mAsset into any given bAsset. The Savings smart contract would be updated to allow users to redeem credits and unwrap them into any bAsset and finally send it to a beneficiary.

With theses proposed changes, it will possible to deposit and withdraw from ETH or any stablecoin on mStable into imUSD, and the imUSD vault in _one transaction_.

## Motivation

Most of the users perform both transactions to deposit into the save contract and vault directly in one step. Additionally, users also mint mUSD and directly deposit it as well. While when withdrawing, the user needs first to redeem from the imUSD Vault to imUSD as one transaction, secondly to redeem from imUSD into mUSD as a second transaction and if the user desires to withdraw the bAsset (DAI, UDSC, USDT, sUSD) a third transaction would be needed. By giving the option to do it in one transaction makes it easier for users and other smart contracts to interact with mStable save product. Improving user experience and developer experience.

As an additional improvement over Savings Contract, it could be possible to add a referral address while depositing savings, this would trigger a `Referral` event with the following details: referral address, the beneficiary and the underlying asset; therefore enabling to track deposits for the mStable Alliance program as described in [MIP 22](./mip-22).

## Specification

The following alterations are proposed.

### mStable Alliance

Update `SavingsContract` to add a new method `depositSavings` with an optional referrer address, that would trigger a `Referral` event with the following details: referral address, the beneficiary and the underlying asset. This Event would be used to generate the data to credit partners in the mStable Allience program.

### Unwrapper

A new new smart contract `Unwrapper` with its main method `unwrapAndSend` that supports converting imAsset/mAsset to both bAsset or fAsset, then send it to a beneficiary address. This new smart contract provides to abstract the logic of redeeming when the _output_ token is a bAsset or to swap when the _output_ token is an fAsset.

### Redeem from imAsset/mAsset to bAsset/fAsset

Update `SavingsContract` with a new method `redeemAndUnwrap` with a parameter `address _beneficiary`

1. Redeems as normal but does not do a token transfer.
2. Approves and calls the `Unwrapper.unwrapAndSend` with the target `bAsset/fAsset` and `beneficiary` address.

### Redeem from vault to bAsset/fAsset

Update `BoostedVault` with a new method `withdrawAndUnwrap` with a parameter `address _beneficiary`

1. Redeems as normal but does not do a token transfer
2. Approves and calls `SavingsContract.redeemAndUnwrap` with the target `bAsset/fAsset` and `beneficiary` address.

## Technical Specification

### Save interface

**Ensures backwards compatibility** by maintaining all functions from the [previous SAVE interface](https://github.com/mstable/mStable-contracts/blob/master/contracts/interfaces/ISavingsContract.sol).

Adds additional external functions to the Interface:

- `depositSavings` : For mStable Alliance
- `redeemAndUnwrap`: For Redeem from imAsset/mAsset to bAsset/fAsset

```typescript
interface ISavingsContractV3 {
    // DEPRECATED but still backwards compatible
    function redeem(uint256 _amount) external returns (uint256 massetReturned);

    function creditBalances(address) external view returns (uint256); // V1 & V2 (use balanceOf)

    // --------------------------------------------

    function depositInterest(uint256 _amount) external; // V1 & V2

    function depositSavings(uint256 _amount) external returns (uint256 creditsIssued); // V1 & V2

    function depositSavings(uint256 _amount, address _beneficiary)
        external
        returns (uint256 creditsIssued); // V2

    function redeemCredits(uint256 _amount) external returns (uint256 underlyingReturned); // V2

    function redeemUnderlying(uint256 _amount) external returns (uint256 creditsBurned); // V2

    function exchangeRate() external view returns (uint256); // V1 & V2

    function balanceOfUnderlying(address _user) external view returns (uint256 underlying); // V2

    function underlyingToCredits(uint256 _underlying) external view returns (uint256 credits); // V2

    function creditsToUnderlying(uint256 _credits) external view returns (uint256 underlying); // V2

    function underlying() external view returns (IERC20 underlyingMasset); // V2

    // --------------------------------------------

    function redeemAndUnwrap(
        uint256 _amount,
        bool _isCreditAmt,
        uint256 _minAmountOut,
        address _output,
        address _beneficiary,
        address _router,
        bool _isBassetOut
    ) external returns (uint256 creditsBurned, uint256 massetReturned);

    function depositSavings(
        uint256 _underlying,
        address _beneficiary,
        address _referrer
    ) external returns (uint256 creditsIssued);
}
```

### Redeem from vault to bAsset/fAsset (Mainnet)

**Ensures backwards compatibility** by maintaining all functions from the [previous IBoostedVaultWithLockup interface](https://github.com/mstable/mStable-contracts/blob/master/contracts/interfaces/IBoostedVaultWithLockup.sol).

Add additional external function `withdrawAndUnwrap` to the Interface:

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
     * @dev Withdraws given stake amount from the pool and
     * redeems the staking token into a given asset.
     * @param _amount        Units of the staked token to withdraw
     * @param _minAmountOut  Minimum amount of `_output` to receive
     * @param _output        Address of desired output b/f-Asset
     * @param _beneficiary   Address to send output and any claimed reward to
     * @param _router        Router address to redeem/swap
     * @param _isBassetOut   Route action of redeem/swap
     */
    function withdrawAndUnwrap(
        uint256 _amount,
        uint256 _minAmountOut,
        address _output,
        address _beneficiary,
        address _router,
        bool _isBassetOut
    ) external;

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
    function earned(address _account) external view returns (uint256);

    /**
     * @dev Calculates all unclaimed reward data, finding both immediately unlocked rewards
     * and those that have passed their time lock.
     * @param _account User address
     * @return amount Total units of unclaimed rewards
     * @return first Index of the first userReward that has unlocked
     * @return last Index of the last userReward that has unlocked
     */
    function unclaimedRewards(address _account)
        external
        view
        returns (
            uint256 amount,
            uint256 first,
            uint256 last
        );
}
```

### Redeem from vault to bAsset/fAsset (Polygon)

Add additional external function `withdrawAndUnwrap` to the Interface `IStakingRewardsWithPlatformToken`:

```typescript
interface IStakingRewardsWithPlatformToken {
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
     */
    function exit() external;

    /**
     * @dev Withdraws given stake amount from the pool
     * @param _amount Units of the staked token to withdraw
     */
    function withdraw(uint256 _amount) external;

    /**
     * @dev Withdraws given stake amount from the pool and
     * redeems the staking token into a given asset.
     * @param _amount        Units of the staked token to withdraw
     * @param _minAmountOut  Minimum amount of `_output` to receive
     * @param _output        Address of desired output b/f-Asset
     * @param _beneficiary   Address to send output and any claimed reward to
     * @param _router        Router address to redeem/swap
     * @param _isBassetOut   Route action of redeem/swap
     */
    function withdrawAndUnwrap(
        uint256 _amount,
        uint256 _minAmountOut,
        address _output,
        address _beneficiary,
        address _router,
        bool _isBassetOut
    ) external;

    /**
     * @dev Claims outstanding rewards (both platform and native) for the sender.
     * First updates outstanding reward allocation and then transfers.
     */
    function claimReward() external;

    /**
     * @dev Claims outstanding rewards for the sender. Only the native
     * rewards token, and not the platform rewards
     */
    function claimRewardOnly() external;

    /**
     * @dev Gets the last applicable timestamp for this reward period
     */
    function lastTimeRewardApplicable() external view returns (uint256);

    /**
     * @dev Calculates the amount of unclaimed rewards a user has earned
     * @return 'Reward' per staked token
     */
    function rewardPerToken() external view returns (uint256, uint256);

    /**
     * @dev Calculates the amount of unclaimed rewards a user has earned
     * @param _account User address
     * @return Total reward amount earned
     */
    function earned(address _account) external view returns (uint256, uint256);
}

```

#### Migration

The following contracts need to be updated via proxy:

- Mainnet imUSD Savings Vault `0x78BefCa7de27d07DC6e71da295Cc2946681A6c7B`
- Mainnet imBTC Savings Vault `0xF38522f63f40f9Dd81aBAfD2B8EFc2EC958a3016`
- Mainnet imUSD (SavingsContractV2 → SavingsContractV3) `0x30647a72Dc82d7Fbb1123EA74716aB8A317Eac19`
- Mainnet imBTC (SavingsContractV2 → SavingsContractV3) `0x17d8CBB6Bce8cEE970a4027d1198F6700A7a6c24`

- Polygon imUSD Savings Vault `0x32aBa856Dc5fFd5A56Bcd182b13380e5C855aa29`
- Polygon imUSD (SavingsContractV2 → SavingsContractV3) `0x5290Ad3d83476CA6A2b178Cd9727eE1EF72432af`

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
