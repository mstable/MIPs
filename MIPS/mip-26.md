---
mip: 26
title: Stop COMP & stkAAVE Liquidations
status: WIP
author: mZero2Nine (@mzero2nine), Dimitri Golecko (@dimsome)
discussions-to:
created: 2022-02-15
---

## Simple Summary

It is proposed to alter the current workflow on Ethereum mainnet of regularly liquidating all earned COMP and stkAAVE rewards from platform deposits to Compound and Aave for Save users and changing this process to instead reroute rewards to the TreasuryDAO for Asset Management and diversification purposes.

## Abstract

In line with the current overhaul of protocol sustainability for 2022 and beyond, the project ought to now look at the current process & efficiency of continuously liquidating accrued COMP & stkAAVE from the contracts in order to boost the yield of Save users.

We’re often spending [close to 10% of the total value of these tokens](https://etherscan.io/tx/0xb306128ee0a5c202578b59ee68d8c3fbe2e40eb6b35d0ee88aa8a8f32d6ccb71) in gas fees to complete the operation, which is not sustainable in the long-term, and [yields only marginal improvements to Save users](https://forum.mstable.org/t/rfc-stop-comp-stkaave-liquidations/787/3), which is neither efficient nor retaining value in the DAO moving forward.

The entire token liquidation process currently happens manually, so changing this workflow is extremely simple, and further down the line could be automated completely, as it will no longer involve the queuing up of transactions via Flashbots to protect from [Sandwich Attacks](https://sandwiched.wtf/).

It is suggested to retain all stkAAVE in the Asset Management subDAO for the time being, and accumulate COMP until it is economically feasible to deposit them into Compound Finance or use otherwise as the Meta Governors see fit.

In regards to the claiming operation, this can be done once per quarter to minimize transaction and fee overhead.

## Motivation

Since the inception of Save, [we’re continually liquidating all platform rewards](https://etherscan.io/address/0xe595d67181d701a5356e010d9a58eb9a341f1dbd) from Compound & Aave to boost Save users’ returns. Over time, this has continuously given less and less additional yield to savers, while increasing gas costs for the protocol.

Additional discussions around this very topic [have already happened twice](https://forum.mstable.org/t/re-igniting-the-save-liquidation-discussion/493) in the forums, and the time is ripe to take actionable steps and instead reroute all platform rewards to the TreasuryDAO in order to secure a long-term stake in the protocols mStable utilizes for their own product, all the while saving the Treasury thousands of mUSD worth of gas in the process.

Once the treasury starts accumulating these tokens, it can use the additional yield generated to benefit the mStable ecosystem via compounding or other means of increasing value for all MTA holders sustainably in the long run, as well as ensure that mStable retains governance rights in the platforms it depends upon for its day-to-day operations.

This step will increase the value of the protocol and consequently for MTA holders. We are in a sense exchanging platform rewards for MTA. Savers get MTA and we get COMP and stkAAVE. Both win, since savers receive a portion of these earned rewards as a share of the MTA supply, while the treasury is left with nothing.

1.) A new smart contract `Unliquidator` will be deployed to replace the [currently deployed `Liquidator`](https://github.com/mstable/mStable-contracts/blob/master/contracts/masset/liquidator/Liquidator.sol). As the previous smart contract was conceptualized to claim rewards (mainly stkAave and COMP), and liquidate those, the new smart contract will be used for claiming and transferring the rewards the [Asset Management subDAO](https://etherscan.io/address/0x67905d3e4fec0c85dce68195f66dc8eb32f59179). The contract will be deployed with the following parameters:

- `address nexus = 0xAFcE80b19A8cE13DEc0739a1aaB7A028d6845Eb3`
- `address receiverSafe = 0x67905d3e4fec0c85dce68195f66dc8eb32f59179`

  2.) The new module needs to be proposed from the ProtocolDAO multisig to the Nexus and accepted after 7 days.

- `proposeModule(keccak256(toUtf8Bytes("Liquidator")), unliquidatorAddress)`
- `acceptProposedModule(keccak256(toUtf8Bytes("Liquidator"))`

  3.) Call each integrator smart contract ProtocolDAO multisig to approve the newly deployed contract to transfer rewards tokens to the [Asset Management subDAO](https://etherscan.io/address/0x67905d3e4fec0c85dce68195f66dc8eb32f59179):

- `approveRewardToken()`
- [mUSD Aave V2 Integration](https://etherscan.io/address/0xa2a3cae63476891ab2d640d9a5a800755ee79d6e): `0xa2a3cae63476891ab2d640d9a5a800755ee79d6e`
- [mUSD Compound Integration](https://etherscan.io/address/0xd55684f4369040c12262949ff78299f2bc9db735): `0xd55684f4369040c12262949ff78299f2bc9db735`
- [mBTC Aave V2 Integration](https://etherscan.io/address/0xC9451a4483d1752a3E9A3f5D6b1C7A6c34621fC6): `0xC9451a4483d1752a3E9A3f5D6b1C7A6c34621fC6`
- [BUSD Aave V2 Integration](https://etherscan.io/address/0x875d56e691a4c85b32e13d6ac846f6a84bc57384): `0x875d56e691A4c85b32E13d6aC846f6A84Bc57384`
- [GUSD Aave V2 Integration](https://etherscan.io/address/0x85306936842eb09d9cea45bffaec7a81d126508d): `0x85306936842Eb09D9Cea45BffAEc7A81D126508D`
- [RAI Aave V2 Integration](https://etherscan.io/address/0x8cc6a1ae38743d453f2522c5228b775d145f43b7): `0x8cc6a1ae38743d453f2522c5228b775d145f43b7`
- [FEI Aave V2 Integration](https://etherscan.io/address/0x4094aec22f40f11c29941d144c3dc887b33f5504): `0x4094AeC22f40F11c29941d144C3DC887B33f5504`

## Technical Specification

The contract `Unliquidator` has the following functions:

```solidity
/**
  * @notice Updates a new receive address for the tokens
  * @param  _receiver  Address to which the tokens will be send at the end
  */
function updateReceiver(address _receiver) external onlyGovernance;

/**
  * @notice Claims the rewards and sends them to the receiverSafe, e.g. claims and sends stkAave
  * @param  _integration  Integration address, this contract should have permissions to spend the token
  * @param  _token  Address of the token that are claimed and send
  */
function claimAndDistributeRewards(address _integration, address _token) external;

/**
  * @notice Sends rewards them to the receiverSafe, without claiming them e.g. COMP can be claimed by anyone
  * @param  _integration  Integration address, this contract should have permissions to spend the token
  * @param  _token  Address of the token that are transferred
  */
function distributeRewards(address _integration, address _token) external;
```

Only the set Governance Module, in this case the ProtocolDAO Multisig, can change the address via `setReceiver` that will receive the Unliquidated tokens. A change would require an MCCP to be passed before.

The claim functions are both token agnostic and can claim and send those to the Asset Management subDAO. For stkAAVE the function`claimAndDistributeRewards` claims the tokens via an exposed function from the integration before transferring to the recipient address. COMP can be claimed from any address on another address's behalf, the function `distributeRewards` can then transfer these to the set address. Both functions can be called by anyone since they simply transfer tokens to the Asset Management subDAO.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
