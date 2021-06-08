---
mccp: 7
title: MTA rewards distribution on Polygon
status: Proposed
author: derc
discussions-to: https://forum.mstable.org/t/pdp-24-mta-rewards-distribution-on-polygon/503
created: 2021-06-04
---


## Simple Summary

It is proposed to amend [MCCP-4](../MCCP/mccp-4) to carve out ***XX%(To be Voted on)*** of base emissions ***(i.e. XXK MTA per week(To be Voted on))*** for liquidity mining on Polygon, with incentives going to the Save Vault and Feeder Pools. Incentives could be used for joint-liquidity mining programs with partners.


## Abstract

[MCCP-4](../MCCP/mccp-4) proposed a prospective emission schedule over the next few years and a set of rules to follow in order to calculate weekly distributions.

The current emissions schedule on MTA is approximately ~250K MTA per week on Ethereum Mainnet, distributed across 4 Feeder Pools, 2 Savings Vault, MTA/WETH Uniswap LP and MTA Staking. 

MCCP-4 also proposed mStable incentivises liquidity in-house instead of third party protocols in order to promote boost in-house liquidity and channel fees within the protocol. Since MCCP-4 was passed, mStable has deployed on Polygon and accumulated deposits to Save even without incentives. 

In this amendment, we propose that mStable carves out 25% of base emissions as incentives to attract liquidity on Polygon **for 3 months, with a renewed vote after.**

The Polygon team has agreed to launch a joint-liquidity mining program on Polygon with MATIC rewards from their #DeFiForAll fund, with more potential partners in the pipeline. It is proposed that the carved out emissions will go to both the Save Vault and Feeder Pools on Polygon.


## Motivation

Polygon offers users an affordable way to interact with DeFi protocols, and mStable is at the forefront of this space with a best-in-class savings product with integrated liquidity pooling and same-asset swaps. We were also among the first protocols to deploy on Polygon, demonstrating our commitment to make DeFi more accessible to all.


## Specification

This proposal suggests split up the `total_emission` into two new variables:

1. `total_emission_ethereum = total_emission * 0.75` 
2. `total_emission_polygon = total_emission * 0.25` 

[MCCP-4](../MCCP/mccp-4) will remain intact with all the specified calculations and only the `total_emission` in that proposal will be replaced by `total_emission_ethereum`.

The total rewards received by imAsset vaults and feeder pools on Polygon is denoted as `total_emission_polygon`. A fixed percentage of `total_emission_polygon` denoted as `feeder_emission_pct` goes to the feeder pools.

```python
feeder_emission = total_emission_polygon * feeder_emission_pct
vault_emission = total_emission_polygon * (1 - feeder_emission_pct)
```

The emission internally between pools are distributed according to their performance in the previous week. However, before we look into performance, a fixed percentage `base_emission_pct` of emission to feeder pools is distributed equally to the mAsset's feeder pools. In other words, each feeder pools receive a base reward of

```python
feeder_base_emission = feeder_emission * base_feeder_emission_pct / n # MTA
vault_base_emission = vault_emission * base_vault_emission_pct / m # MTA
```

where `n` is the number of feeder pools and `m` is number of mAsset vaults.

On top of base rewards, each pool receives bonus rewards based on their performance from the previous week. We derive a simple performance metric from the volume and liquidity of the pool, according to

```python
# For each feeder pool i
bonus_feeder_factor[i] = volume[i] / liquidity[i]**(1/4)
# For each mAsset vault i
bonus_vault_factor[i] = volume[i] / liquidity[i]**(1/4)
```

where `volume` is the value of the sum of all trades that were executed by the pool in the past week, and `liquidity` is the value of the time weighted average of total liquidity in the feeder pool in the past week.

Pools receive rest of the rewards proportional to their bonus factors:

```python
bonus_feeder_emission[i] = feeder_emission * (1 - base_feeder_emission_pct) \
        * bonus_feeder_factor[i] / sum(bonus_feeder_factor)
bonus_vault_emission[i] = vault_emission * (1 - base_vault_emission_pct) \
        * bonus_vault_factor[i] / sum(bonus_vault_factor)
```

Finally, the total emissions a feeder pool and a vault receive are computed as the sum of the base emission and bonus emission

```python
total_feeder_emission[i] = feeder_base_emission + bonus_feeder_emission[i]
total_vault_emission[i] = vault_base_emission + bonus_vault_emission[i]
```

It is proposed that:

- `feeder_emission_pct = 0`
- `base_feeder_emission_pct = 0.2`
- `base_vault_emission_pct = 0.5`


## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/)
