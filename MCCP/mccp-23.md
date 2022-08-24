---
mccp: 23
title: Disable underutilized dials II
status: Approved
author: Dimitri Golecko (@dimsome), Julian Kusnetzoff (@jkusne)
discussions-to: https://forum.mstable.org/t/mccp-23-disable-underutilized-dials-ii/911
created: 2022-07-27
---

## Simple Summary

It is proposed to disable the second batch of underutilized dials in the Emissions Controller as launched with [MIP 24](../MIPS/mip-24) in order to avoid incentivising pools that receive a substantial amount of MTA per epoch but do not contribute effectively to the usage of the mStable protocol and add value by contributing to overall revenue.

## Abstract

Dials receive votes from MTA stakers that decide the allocation of newly emitted MTA. Some participants choose to actively shift their allocation while others allocate once and allow it to be dormant. This creates a dynamic in which some of the dials receive fairly few votes from a few individuals that haven’t adjusted their weights in a long while.

The first set of dials was disabled with [MCCP 22](./mccp-22). This resulted in a much more streamlined emission process by avoiding dust MTA to be sent to illiquid pools.

This proposal seeks to further disable more dials and make MTA emissions more capital efficient.

As per the [temperature check](https://forum.mstable.org/t/temperature-check-emissions-controller/902) results, the proposal will have two alternative choices:

- **Disable most dials but keep:**
  - MTA Staking
  - mBPT Staking
  - TreasuryDAO
- **Disabling some dials but keep:**
  - MTA Staking
  - mBPT Staking
  - TreasuryDAO
  - imUSD Vault
  - imUSD Vault Polygon
- **Don’t disable any more dials**

## Motivation

Liquidity mining programs have proven to be ineffective for achieving long term, sustainable growth, resulting in a loss of liquidity when they are ended and a lower token price due to liquidity providers selling the reward token to increase their yield. At the same time, the market conditions have changed, and many protocols are ending these programs. This proposal aims to protect MTA holders capital.

## Specification

The following dials are proposed pending the results of the vote are to be disabled in the Emissions Controller ([0xBa69e6FC7Df49a3b75b565068Fb91ff2d9d91780](https://etherscan.io/address/0xBa69e6FC7Df49a3b75b565068Fb91ff2d9d91780)) on Ethereum Mainnet:

| Dial              | Destination Network | Recipient address                          | Dial Id |
| ----------------- | ------------------- | ------------------------------------------ | ------- |
| imBTC Vault       | Ethereum            | 0xF38522f63f40f9Dd81aBAfD2B8EFc2EC958a3016 | 3       |
| GUSD Feeder Pool  | Ethereum            | 0xAdeeDD3e5768F7882572Ad91065f93BA88343C99 | 4       |
| BUSD Feeder Pool  | Ethereum            | 0xD124B55f70D374F58455c8AEdf308E52Cf2A6207 | 5       |
| RAI Feeder Pool   | Ethereum            | 0xF93e0ddE0F7C48108abbD880DB7697A86169f13b | 7       |
| FRAX Feeder Pool  | Polygon PoS         | 0x38dD64B51C1808b04493324f334350eBB3AE8d11 | 12      |
| MTA Balancer Pool | Polygon PoS         | 0x4e649Fa2f3C0Ff18b7695d1e1fa371a1999187Dc | 13      |
| Votium Bribe      | Ethereum            | 0xb6d519a0D616f6F5Fac2b1dBC5bcb92ea58EDa4a | 15      |
| Vesper Finance    | Ethereum            | 0x849b0586cb4aC9873E095939D5A076719F354968 | 17      |
| Idle Finance      | Ethereum            | 0xD2192aa940588851541086D03942572E02CF71B4 | 18      |

## Technical Specification

For each of the dials to be disabled the following function will be called from the ProtocolDAO multisig:

Emissions Controller ([0xBa69e6FC7Df49a3b75b565068Fb91ff2d9d91780](https://etherscan.io/address/0xBa69e6FC7Df49a3b75b565068Fb91ff2d9d91780#code)):

- `updateDial(uint256 _dialId, bool _disabled, bool _notify)`
  - `_dialId =` See table in specifications
  - `_disabled = true` Changing the flag to disable the dial
  - `_notify =` get the current value of the flag, set to the same value

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
