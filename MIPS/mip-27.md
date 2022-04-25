---
mip: 27
title: Upgrade Save Contract to comply with ERC-4626
status: Proposed
author: Dimitri Golecko (@dimsome), Cesar Chavez (@doncesarts)
discussions-to: https://forum.mstable.org/
created: 2022-04-21
---

## Simple Summary

It is proposed to upgrade to our Savings Contracts (imUSD and imBTC) on Ethereum Mainnet and Polygon in order to support the [ERC-4626](https://eips.ethereum.org/EIPS/eip-4626) standard, while still preserving the current functions to allow for backwards compatibility.

## Abstract

[ERC-4626](https://eips.ethereum.org/EIPS/eip-4626) is a new standard for yield-bearing Vaults. As discussed in the previous community calls, mStable is leaning further into the Save concept and seeks to embrace this new standard.

Therefore, we would like to make the first step by upgrading our current yield-bearing contracts (Save Contract or imUSD and imBTC) on Polygon and Ethereum mainnet to be compatible with this standard. The contract already is quite similar to the standard but requires a few changes to be 100% compliant.

Following that, the new implementation of the Save Contracts needs to be deployed and the Proxy needs to be pointed to the new Implementation.

Users are not required to perform any actions. Other protocols that integrated the contracts and our front-end do not need to be updated. But new integrations can use the standard interface to interact with the upgraded smart contract.

## Motivation

This follows our recent shift of focus towards the Save Concept and the embracement of the ERC-4626 standard. This step makes sense in this light as we would want to push this standard forward and be a key player with this new standard.

Additionally, following this standard could open up the door to new integrations with new protocols that adopt this standard early. One of which is Turbo Tribe, which **[allows any DeFi token to become productive by sharing in the yield generated from a costless FEI line of credit](https://medium.com/fei-protocol/the-tribe-dao-strongly-believes-that-a-healthy-and-thriving-defi-ecosystem-needs-a-robust-platform-b1faea700dfa)**. It is to be expected that more protocols will find uses cases for contracts following this standard.

## Specification

Deploy the new Implmenetation and Upgrade the proxy contract `SavingsContract` for imUSD, imBTC on Ethereum mainnet and imUSD on polygon:

- Mainnet imUSD: `0x30647a72Dc82d7Fbb1123EA74716aB8A317Eac19`
- Mainnet imBTC: `0x17d8CBB6Bce8cEE970a4027d1198F6700A7a6c24`
- Polygon imUSD : `0x5290Ad3d83476CA6A2b178Cd9727eE1EF72432af`

## Technical Specification

The existing Save interface as defined latest in MIP-25 remains intact and ensures backwards compatibility.

### IERC-4626

The following interface is used to add functions for being compliant with the standard ERC-4626. This interface is inherited by the `SavingsContract`. The functions in the `SavingsContract` that are ERC-4626 compatible map the functionality to existing functions and therefore don’t change the core functionality.

```solidity
interface IERC4626Vault is IERC20 {
    /// @notice The address of the underlying token used for the Vault uses for accounting, depositing, and withdrawing
    function asset() external view returns (address assetTokenAddress);

    /// @notice Total amount of the underlying asset that is “managed” by Vault
    function totalAssets() external view returns (uint256 totalManagedAssets);

    /**
     * @notice The amount of shares that the Vault would exchange for the amount of assets provided, in an ideal scenario where all the conditions are met.
     * @param assets The amount of underlying assets to be convert to vault shares.
     * @return shares The amount of vault shares converted from the underlying assets.
     */
    function convertToShares(uint256 assets) external view returns (uint256 shares);

    /**
     * @notice The amount of assets that the Vault would exchange for the amount of shares provided, in an ideal scenario where all the conditions are met.
     * @param shares The amount of vault shares to be converted to the underlying assets.
     * @return assets The amount of underlying assets converted from the vault shares.
     */
    function convertToAssets(uint256 shares) external view returns (uint256 assets);

    /**
     * @notice The maximum number of underlying assets that caller can deposit.
     * @param caller Account that the assets will be transferred from.
     * @return maxAssets The maximum amount of underlying assets the caller can deposit.
     */
    function maxDeposit(address caller) external view returns (uint256 maxAssets);

    /**
     * @notice Allows an on-chain or off-chain user to simulate the effects of their deposit at the current block, given current on-chain conditions.
     * @param assets The amount of underlying assets to be transferred.
     * @return shares The amount of vault shares that will be minted.
     */
    function previewDeposit(uint256 assets) external view returns (uint256 shares);

    /**
     * @notice Mint vault shares to receiver by transferring exact amount of underlying asset tokens from the caller.
     * @param assets The amount of underlying assets to be transferred to the vault.
     * @param receiver The account that the vault shares will be minted to.
     * @return shares The amount of vault shares that were minted.
     */
    function deposit(uint256 assets, address receiver) external returns (uint256 shares);

    /**
     * @notice The maximum number of vault shares that caller can mint.
     * @param caller Account that the underlying assets will be transferred from.
     * @return maxShares The maximum amount of vault shares the caller can mint.
     */
    function maxMint(address caller) external view returns (uint256 maxShares);

    /**
     * @notice Allows an on-chain or off-chain user to simulate the effects of their mint at the current block, given current on-chain conditions.
     * @param shares The amount of vault shares to be minted.
     * @return assets The amount of underlying assests that will be transferred from the caller.
     */
    function previewMint(uint256 shares) external view returns (uint256 assets);

    /**
     * @notice Mint exact amount of vault shares to the receiver by transferring enough underlying asset tokens from the caller.
     * @param shares The amount of vault shares to be minted.
     * @param receiver The account the vault shares will be minted to.
     * @return assets The amount of underlying assets that were transferred from the caller.
     */
    function mint(uint256 shares, address receiver) external returns (uint256 assets);

    /**
     * @notice The maximum number of underlying assets that owner can withdraw.
     * @param owner Account that owns the vault shares.
     * @return maxAssets The maximum amount of underlying assets the owner can withdraw.
     */
    function maxWithdraw(address owner) external view returns (uint256 maxAssets);

    /**
     * @notice Allows an on-chain or off-chain user to simulate the effects of their withdrawal at the current block, given current on-chain conditions.
     * @param assets The amount of underlying assets to be withdrawn.
     * @return shares The amount of vault shares that will be burnt.
     */
    function previewWithdraw(uint256 assets) external view returns (uint256 shares);

    /**
     * @notice Burns enough vault shares from owner and transfers the exact amount of underlying asset tokens to the receiver.
     * @param assets The amount of underlying assets to be withdrawn from the vault.
     * @param receiver The account that the underlying assets will be transferred to.
     * @param owner Account that owns the vault shares to be burnt.
     * @return shares The amount of vault shares that were burnt.
     */
    function withdraw(
        uint256 assets,
        address receiver,
        address owner
    ) external returns (uint256 shares);

    /**
     * @notice The maximum number of shares an owner can redeem for underlying assets.
     * @param owner Account that owns the vault shares.
     * @return maxShares The maximum amount of shares the owner can redeem.
     */
    function maxRedeem(address owner) external view returns (uint256 maxShares);

    /**
     * @notice Allows an on-chain or off-chain user to simulate the effects of their redeemption at the current block, given current on-chain conditions.
     * @param shares The amount of vault shares to be burnt.
     * @return assets The amount of underlying assests that will transferred to the receiver.
     */
    function previewRedeem(uint256 shares) external view returns (uint256 assets);

    /**
     * @notice Burns exact amount of vault shares from owner and transfers the underlying asset tokens to the receiver.
     * @param shares The amount of vault shares to be burnt.
     * @param receiver The account the underlying assets will be transferred to.
     * @param owner The account that owns the vault shares to be burnt.
     * @return assets The amount of underlying assets that were transferred to the receiver.
     */
    function redeem(
        uint256 shares,
        address receiver,
        address owner
    ) external returns (uint256 assets);

    /*///////////////////////////////////////////////////////////////
                                Events
    //////////////////////////////////////////////////////////////*/

    /**
     * @dev Emitted when caller has exchanged assets for shares, and transferred those shares to owner.
     *
     * Note It must be emitted when tokens are deposited into the Vault in ERC4626.mint or ERC4626.deposit methods.
     *
     */
    event Deposit(address indexed caller, address indexed owner, uint256 assets, uint256 shares);
    /**
     * @dev Emitted when sender has exchanged shares for assets, and transferred those assets to receiver.
     *
     * Note It must be emitted when shares are withdrawn from the Vault in ERC4626.redeem or ERC4626.withdraw methods.
     *
     */
    event Withdraw(
        address indexed caller,
        address indexed receiver,
        address indexed owner,
        uint256 assets,
        uint256 shares
    );
}
```

### ISavingsContractV4

In order to add the functionality to supply a `referrer` address during deposit, this interface has been added to allow the functions to be called in a similar way to the ERC-4626 standard. However, the `referrer` argument is not part of the ERC-4626 specifications.

```solidity
interface ISavingsContractV4 is
    IERC4626Vault // V4
{
    // DEPRECATED but still backwards compatible
    function redeem(uint256 _amount) external returns (uint256 massetReturned); // V1  (use IERC4626Vault.redeem)

    function creditBalances(address) external view returns (uint256); // V1 & V2 (use balanceOf)

    // --------------------------------------------
    function depositInterest(uint256 _amount) external; // V1 & V2

    /** @dev see IERC4626Vault.deposit(uint256 assets, address receiver)*/
    function depositSavings(uint256 _amount) external returns (uint256 creditsIssued); // V1 & V2

    /** @dev see IERC4626Vault.deposit(uint256 assets, address receiver)*/
    function depositSavings(uint256 _amount, address _beneficiary)
        external
        returns (uint256 creditsIssued); // V2

    /** @dev see IERC4626Vault.redeem(uint256 shares,address receiver,address owner)(uint256 assets);*/
    function redeemCredits(uint256 _amount) external returns (uint256 underlyingReturned); // V2

    /** @dev see IERC4626Vault.withdraw(uint256 assets,address receiver,address owner)(uint256 assets, address receiver)*/
    function redeemUnderlying(uint256 _amount) external returns (uint256 creditsBurned); // V2

    function exchangeRate() external view returns (uint256); // V1 & V2

    function balanceOfUnderlying(address _user) external view returns (uint256 underlying); // V2

    function underlyingToCredits(uint256 _underlying) external view returns (uint256 credits); // V2

    function creditsToUnderlying(uint256 _credits) external view returns (uint256 underlying); // V2

    /** @dev see IERC4626Vault.asset()(address assetTokenAddress);*/
    function underlying() external view returns (IERC20 underlyingMasset); // V2

    function redeemAndUnwrap(
        uint256 _amount,
        bool _isCreditAmt,
        uint256 _minAmountOut,
        address _output,
        address _beneficiary,
        address _router,
        bool _isBassetOut
    )
        external
        returns (
            uint256 creditsBurned,
            uint256 massetRedeemed,
            uint256 outputQuantity
        ); // V3

    function depositSavings(
        uint256 _underlying,
        address _beneficiary,
        address _referrer
    ) external returns (uint256 creditsIssued); // V3

    // -------------------------------------------- V4
    function deposit(
        uint256 assets,
        address receiver,
        address referrer
    ) external returns (uint256 shares);

    function mint(
        uint256 shares,
        address receiver,
        address referrer
    ) external returns (uint256 assets);
}
```

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
