---
tdp: 55
title: TreasuryDAO & ProtocolDAO Signer Compensation and Replacements
status: Proposed
author: Cam Soulsby (@camsoulsby), mZeroNine (@mzero2nine)
discussions-to: https://forum.mstable.org
created: 2022-03-14
---

## Simple Summary

Following the outcome of [MIP 29](../MIPS/mip-29), MTA Governors will soon be asked to vote on the future direction of the mStable project, which may include an acquisition or full shutdown of the mStable products and subsequent shutdown of the the mStableDAO.

As part of [MIP 29](../MIPS/mip-29), normal governance processes, including scheduled sign elections, were temporarily put on hold.

It is therefore proposed to decide on a path forward to ensure a secure and well-functioning signer group to enact the will of MTA Governors for as long as is required based on the outcome of the upcoming [MIP 30](../MIPS/mip-30).

## Abstract

The previous signer rotation officially ended on **15th of February**, and signers have been asked to remain in their posts without compensation temporarily while the path forward for the mStableDAO is established through ongoing governance processes. During this time, the previously proposed process around signer elections was halted.

It is proposed that in order to ensure the security of the ProtocolDAO and TreasuryDAO going forward, the changes outlines below are agreed upon and enacted if this proposal passes successfully.

## Motivation

Our treasury is still arguably very heavily allocated in native MTA, and we're dreadfully underexposed to the rest of the DeFi ecosystem and the myriad opportunities that the different protocols have on offer.

We're slowly rectifiying this issue, though, and I hope that by owning a small portion of the Elastic Finance stack, we can focus our other liquidity endeavours to more exciting things in the future, without needing to visit this primitive again in quite some time, while enjoying the exposure and big upside these assets offer.

## Specification

### Signer Compensation

It is suggested that signer compensation of 1000 USDC per month is reinstated, effective from the 1st of April 2023, until the multisigs are no longer required or until this proposal is superseded by another.

For the ProtocolDAO, compensation of signers would be stopped when the ProtocolDAO relinquished ownership of the Nexus contract. For the TreasuryDAO, compensation would be stopped if the amount of assets custodied by the DAO dropped below $20,000 USD in value. At this point, signers would be requested to remain in their positions without compensation in case their services were needed in the future.

### Signer Structure and Replacement Process

Both the TreasuryDAO and ProtocolDAO must maintain a 4/6 signer structure at all times to ensure security as outlined in [TDP 44](./tdp-44).

If a signer expresses a desire to leave their position outside of a regular election process (which may not be required in the future depending on the outcome of [MIP 30](../MIPS/mip-30), the signer group should work together to find and suggest a new trusted signer and the change should be ratified through a governance vote.

If signer compensation is stopped due to the conditions described in the previous section being met, signer structure could be reduced to a 3/5, 2/3 or 2/4 multisig by agreement within the signer group to allow for easier execution of any required transactions and to allow for any signers who may not wish to be available without compensation.

### Current Signer Changes

The current signer group have been asked if they are willing to continue on as signers to avoid the need for a full election cycle at this time. One member of the TreasuryDAO has indicated that they would like to be rotated out of signer positions. As part of this TDP, it is therefore proposed that this signer, who is a core contributor, is replaced by another core contributor. The incoming core contributor would prefer to keep their identities private but other team members will be able to vouch for their trustworthiness here.

**TreasuryDAO**

* Nesk (0xBb330652D70eF1204d39d0880896B017a1BB1774) replaced by core contributor (0xA31DD58278Ef3777718AD6faFB8b0cebbB23b975).

### Reminder of Scope of Treasury DAO Activities

It should be restated as part of this proposal that the role of TreasuryDAO signers is to enact the will of MTA governors, following the [Treasury charter](https://forum.mstable.org/t/tdp-51-treasurydao-charter/947) voted on earlier this year by MTA governors.

The mandate of TreasuryDAO signers includes:

- Execute transactions relating to treasury assets or disburse funds in line with approved governance proposals
- Compensate signers on a monthly basis as per this proposal
- Compensate mStableDAO Cat Herder for the term of their tenure as decided through governance
- Fund protocol wallets with ETH to cover protocol fees as requested by the ProtocolDAO
- Agree internally on who will take on the role of Operational Signer as defined in [TDP 47](./tdp-47) to facilitate the queuing of transactions in line with governance decisions. Since this role has typically been carried out by full time mStable contributors, and that these roles may no longer exist in the near future, signers should expect they each may be asked to queue transactions from time to time.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
