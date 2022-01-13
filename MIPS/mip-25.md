---
mip: 25
title:  Save Unwrapper
status: WIP
author: Dimitri Golecko (@dimsome), Cesar Chavez (@doncesarts)
discussions-to:
created: 2022-01-13
---

## Simple Summary

Currently, users of the protocol need to perform two transactions to deposit or withdraw from the savings product. The proposed upgrade described in this RFC aims at reducing it to only one transaction in order to ease any interaction with the save product.

## Abstract

To create an Unwrapper smart contract to facilitate the unwrapping of any given credit or mAsset into any given bAsset. 
To upgrade Savings smart contract to allow users to redeem credits and unwrap them into any bAsset and finally send it to a beneficiary. 
In conjunction with these two changes proposed, it will possible to deposit and withdraw from ETH or any stablecoin on mStable into imUSD (which gives you the base USD yield) and the imUSD vault (which opts you into bonus MTA rewards as well) in *one transaction.*

## Motivation

Most of the users perform both transactions while withdrawing, first redeem from the imUSD Vault to  imUSD, secondly a redeem from  imUSD into mUSD. By giving the option to do it in one transaction makes it easier for users and other smart contracts to interact with mStable save product. 

As an additional improvement over Savings Contract, it could be possible to add a referral while depositing savings, this would trigger a `Referral` event with the following details: referral address, the beneficiary and the underlying asset; therefore enabling to track deposits for the mStable Alliance program as described at [[RFC] mStable Alliance Referral program][2].

### Pros

- It makes it easier for users to deposit or withdraw into/from mStable save product.
- It makes it easier for other smart contracts to interact with mStable protocol, making it more appealing for integrations.
- it enables mStable Alliance Program.

### Cons

- Any upgrade to smart contracts could bring risks, although these risks can be mitigated with an exhaustive set of test.


## Specification

### mStable Alliance
Update `SavingsContract` to add a new method `depositSavings` with an optional referrer address, that would trigger a `Referral` event with the following details: referral address, the beneficiary and the underlying asset. 

### Unwrapper  

To implement a new smart contract `Unwrapper` with its main method `unwrapAndSend` that supports converting imAsset/mAsset to both bAsset or fAsset, then send it to a beneficiary address. This new smart contract provides to abstract the logic of redeeming when the *output* token is a bAsset or to swap when the *output* token is an fAsset. 


### Redeem from imAsset/mAsset to bAsset/fAsset

Update `SavingsContract` with a new method `redeemAndUnwrap` and `address _beneficiary`

1. Redeems as normal but does not do a token transfer.
2. Approves and calls the `Unwrapper.unwrapAndSend` with the target `bAsset/fAsset` and `beneficiary` address.

### Redeem from vault to bAsset/fAsset

Update `BoostedVault` with a new method `withdrawAndUnwrap` and `address _beneficiary`

1. Redeems as normal but does not do a token transfer
2. Approves and calls `SavingsContract.redeemAndUnwrap` with the target `bAsset/fAsset` and `beneficiary` address.


## Technical Specification

### Save  interface

**Ensures backwards compatibility** by maintaining all functions from the [previous SAVE interface][3].

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

### Redeem from vault to bAsset/fAsset

**Ensures backwards compatibility** by maintaining all functions from the [previous IBoostedVaultWithLockup interface][4].

Adds additional external functions to the Interface `withdrawAndUnwrap`:

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


#### Migration

Funds in SAVE will require a migration from v2 to v3 in order to continue to accrue interest.
This will be primarily supported on the [mStable-app][5] with changes on the UI that will make it easy for users to 
redeem their imAssets/mAssets into a bAsset/fAsset in one transaction. 

Contracts to upgrade:
- mUSD Savings Vault  `0x78BefCa7de27d07DC6e71da295Cc2946681A6c7B`
- imBTC Savings Vault `0xF38522f63f40f9Dd81aBAfD2B8EFc2EC958a3016`
- Mainnet imUSD (SavingsContractV2 → SavingsContractV3) `0x30647a72Dc82d7Fbb1123EA74716aB8A317Eac19`
- Mainnet imBTC (SavingsContractV2 → SavingsContractV3) `0x17d8CBB6Bce8cEE970a4027d1198F6700A7a6c24`
- Polygon imUSD (SavingsContractV2 → SavingsContractV3) `0x5290Ad3d83476CA6A2b178Cd9727eE1EF72432af`


## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
[1]: https://forum.mstable.org/t/rfc-save-unwrapper/761
[2]: https://forum.mstable.org/t/rfc-mstable-alliance-referral-program/684
[3]: https://github.com/mstable/mStable-contracts/blob/master/contracts/interfaces/ISavingsContract.sol
[4]: https://github.com/mstable/mStable-contracts/blob/master/contracts/interfaces/IBoostedVaultWithLockup.sol
[5]: https://app.mstable.org/#/save

