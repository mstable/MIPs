---
mccp: 13
title: Increase cache for BUSD and GUSD Feeder Pools
status: Implemented
author: Dimitri Golecko (@dimsome)
discussions-to: https://forum.mstable.org/t/mccp-13-increase-cache-for-busd-and-gusd-feeder-pools/747
created: 2021-12-27
---

## Simple Summary

The recent proposal to remove mUSD deposited in the Feeder Pools from the Iron Bank was passed with [MIP 23](../MIPS/mip-23). The contracts to replace the integration are almost ready. However, the migration of both pools is not possible at the same time, because some mUSD is still lent out. Therefore it is proposed to increase the max cached amount to 20% (maximum) to reduce the interaction with the Iron Bank upon depositing into the mUSD/BUSD Feeder Pool and optionally for the mUSD/GUSD Feeder Pool.

## Abstract

One Feeder Pool can be migrated to the dummy integration contract as specified in [MIP 23](../MIPS/mip-23). In the first step, this should be the mUSD/GUSD Feeder Pool, since this pool has a higher TVL. Before that, the max cache could be set as well to `20%` to reduce interactions with the Iron Bank smart contracts in case the review and deployment of the dummy Integration contracts requires additional time.
For the second pool Feeder Pool (mUSD/BUSD) a migration is at the time not possible. The increase of the max cache to `20%` would limit the deposits into the Iron Bank and allow for cheaper transactions, while also increasing the interest rate in the Iron Bank for the borrower and incentivising the repayment of the loan.

Eventually, the second Feeder Pool should be migrated as well, once the loaned out amount is paid back.

## Motivation

This proposal would help with the migration from the Iron Bank to the dummy integration contract that was part of [MIP 23](../MIPS/mip-23). It would in effect lower the amount of mUSD in the Iron Bank, increase the borrowing APY and increase the pressure to repay the loaned amount. In addition, this would also decrease the interaction with the Iron Bank and allow for better functioning Feeder Pools that remain to use the Iron Bank integration until the migration to the dummy integration can be completed successfully.

## Specification

The ProtocolDAO multisig would initiate the following transactions:

- mUSD/BUSD Feeder Pool: `0xfE842e95f8911dcc21c943a1dAA4bd641a1381c6`
  - `setCacheSize(2e17)` (=20%, max as limited by the smart contract)
- (optionally) mUSD/GUSD Feeder Pool: `x4fB30C5A3aC8e85bC32785518633303C4590752d`
  - `setCacheSize(2e17)` (=20%, max as limited by the smart contract)

The set cache is the max cache. In practice, the actual amount would be closer to half the set max cache amount.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/)
