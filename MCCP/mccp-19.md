---
mccp: 19
title: Disable automated collection of fees for Mainnet Save redemptions
status: Proposed
author: Nick Addison (@naddison36)
discussions-to: https://forum.mstable.org/t/mccp-19-disable-automated-collection-of-fees-for-mainnet-save-redemptions/833
created: 2022-03-15
---

## Simple Summary

Reduce gas costs of Mainnet Save (imUSD and imBTC) redemptions by disabling the automated collection of swap and redeem fees.

## Abstract

Around 100k in gas can be avoided from Save redemptions. With a gas price of 100 Gwei, that’s over 30 USD in Ether at today’s Ether prices.

This was implemented when gas costs and Ether prices were a lot lower. There was also a smaller amount of mUSD in Save which meant the missed fees could be significant.

## Motivation

The following Save (SavingsContract) redeem functions are currently configured to automatically collect swap and redeem fees from mUSD:

- redeem
- redeemCredits
- redeemUnderlying
- redeemAndUnwrap (new function coming with the Save Unwrapper)

If Save’s automateInterestCollection is true, SavingsMaanger.collectAndDistributeInterest is called at the start of the redeem functions. SavingsMaanger.collectAndDistributeInterest collects swap and redeem fees from mUSD and transfers 90% of it to Save (SavingsContract). The 10% left is the governance fee.

The collection of the swap and redeem fees is done daily as part of the SavingsManager.collectAndStreamInterest process. eg Ethereum Transaction Hash (Txhash) Details | Etherscan

SavingsMaanger.collectAndDistributeInterest is also called on all Save deposits. There is no config to automatically turn this off.

If automated collection on redeems is disabled, the longest time fees will have not been collected should only be 1 day. But this is likely to be shorter as there are Save deposits during the day.

The amount of daily swap and redeem fees varies as it depends on the swap and redeem volumes. There are only a few days over the last 18 months where over 15k USD was collected. The average for this 2020 year is around 2k in fees daily Dune Analytics. With 44m currently in Save, an extra 2k makes little difference on the imUSD to mUSD exchange rate. The impact is even less if the redeemer does not a Save whale.

Looking at some recent examples, less than 10 mUSD of fees was collected for a gas cost over 30 mUSD. eg this redemption cost 116,124 in gas to only collect 3 mUSD in fees for the Save product Ethereum Transaction Hash (Txhash) Details | Etherscan.

BTC Save (imBTC) on Mainnet can also be configured to not automatically collect swap and redeem fees from mBTC on Save redemptions.

Give gas is still cheap on Polygon, the automated collection of swap and redeem fees of Polygon Save (imUSD) can remain.

## Specification

Call the function `automateInterestCollectionFlag(bool _enabled)` with `_enabled = true` from the ProtocolDAO multisig on the following contracts:

- [0x30647a72Dc82d7Fbb1123EA74716aB8A317Eac19](https://etherscan.io/address/0x30647a72dc82d7fbb1123ea74716ab8a317eac19) (imUSD / mUSD Savings Contract)
- [0x17d8CBB6Bce8cEE970a4027d1198F6700A7a6c24](https://etherscan.io/address/0x17d8cbb6bce8cee970a4027d1198f6700a7a6c24) (imBTC / mBTC Savings Contract)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/)
