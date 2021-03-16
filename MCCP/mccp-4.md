---
mccp: 4
title: Optimise MTA emission to maximise circular effects
status: WIP
author: Alex Scott <@alsco77>, Onur Solmaz <@osolmaz>
discussions-to: https://forum.mstable.org/
created: 2021-03-16
---

<!--You can leave these HTML comments in your merged MCCP and delete the visible duplicate text guides, they will not appear and may be helpful to refer to if you edit it again. This is the suggested template for new MCCPs. Note that an MCCP number will be assigned by an editor. When opening a pull request to submit your MCCP, please use an abbreviated title in the filename, `mccp-draft_title_abbrev.md`. The title should be 44 characters or less.-->

## Simple Summary

<!--"If you can't explain it simply, you don't understand it well enough." Provide a simplified and layman-accessible explanation of the MCCP.-->

_Note: This MCCP assumes a positive resolution to [MIP-9](../MIPS/mip-9)._

It has long been proposed that major optimisations can be made to the MTA emission. This MCCP proposes a major revamp; bringing all the incentives "in-house" to create better circular effects, reduce MTA sell pressure and maximise TVL.

## Abstract

<!--A short (~200 word) description of the variable change proposed.-->

The MCCP proposes that mStable:

- **a)** stop incentivising **mAsset** liquidity on third party protocols and focus entirely on Feeder Pools (e.g. tBTC/mBTC feeder pool, which has an effect of leveraging **&** giving more fees to mAsset save)
- **b)** change the rewards contracts so that X% of MTA is unlocked immediately and Y% is vested over Z months (like the current imUSD vault), with a boost for being an MTA staker
- **c)** plan and project an emission curve to reduce vote count

This MCCP interacts positively with [MIP-8](../MIPS/mip-8) and has the power to set the tokenomics on a different course: increasing mStable TVL, increasing fees to mAsset SAVE, increasing revenue to buy & make, reducing sell pressure for MTA and causing people to be MTA bulls due to the lockup and the rewards gained from being a staker.

## Motivation

<!--The motivation is critical for MCCPs that want to update variables within mStable. It should clearly explain why the existing variable is not incentive aligned. MCCP submissions without sufficient motivation may be rejected outright.-->

Goals:

- Utilise MTA to generate circular effects for mStable
- Maximise mAsset TVL
- Maximise demand for MTA
  - Reduce sell pressure for MTA
- Increase net fees going in to mAsset SAVE
- Leverage utilisation rate for mAsset SAVE

<!-- ALEX - add numbers about vs Curve & Balancer etc -->
<!-- Comparison with other emissions? -->

![Comparative emissions](../assets/MCCP-4/emissions.png)

Taken from [Aave's forum](https://governance.aave.com/t/proposal-introduce-liquidity-incentives-for-aave-v2/2340), this image shows comparative emission rates. All 4 of these projects rewarded liquidity to their own pools, rather than external platforms. This is much more powerful. In addition, it is worth noting that our

## Specification

<!--Technical rationale and specifics of the change-->

<!-- WEEK 1 numbers -->
<!-- Numbers for new mAssets (mETH, mEUR) -->
<!-- Total emission  -->

<!-- Start: 133k
 Peak: 6 months 288k
 Finish: 5 years after at 0k then inflation
 40k Needs to go to staking each week
 Of the remainder: all to mAssets, mainly mUSD and mBTC
 Internal mAsset: 80% to feeders and 20% to vault (ballpark) -->

<!--

Either include text based Levers, or use the stuff form the Hackmd etc

Levers (should probably address each of these in the specification):

- MTA emission (40m tokens roughly)
  - quantity
  - destination (feeder pool rewards contracts or imAsset vaults probably)
- buy and make revenue (main pool)
  - percentage
- governance fee (feeder pools)
  - percentage
  - destination
- rewards contract config
  - lockup + boost (like the imUSD vault at the min)
    - boost magnitude (**5x rewards for staking to leverage rwds -** this could create major demand for MTA) (e.g. 18-80% shown on the dashboard as 1-5x)
    - boost MTA required
    - % of rewards locked up (benchmark is 33%)
    - length of reward lockup (benchmark is 6 months)
  - rewards token (MTA ... or 80/20 MTA/ETH Balancer pool token)
    - When the airdrop happens, provide single sided liquidity to balancer for the 80/20 BPT
    - Rewards accrue in BPT
    - When user withdraws the reward, it simply withdraws into MTA tokens -->

| Pool allocations   | Current | Proposed (Week 1) |
| ------------------ | ------- | ----------------- |
| imBTC Vault        | 0       | XXX               |
| mBTC/ETH Sushiswap | 15000   | XXX               |
| imUSD Vault        | 12000   | XXX               |
| mUSD Curve         | 13750   | XXX               |
| mUSD/WETH Balancer | 23750   | XXX               |
| **TOT mAssets**    | 64500   | XXX               |
| MTA/WETH Uniswap   | 28750   | XXX               |
| Staking            | 40000   | XXX               |
| **TOT MTA**        | 68750   | XXX               |
| **TOT**            | 133250  | XXX               |

## Rationale

We want to have a mathematical way of reasoning when we set emissions to certain parts of the protocol. To this end, we set forth to create a comprehensive model with a level of detail sufficient to capture the token economics and market dynamics of each pool. The overarching purpose of the model is to maximize the TVL of the whole protocol by finding the optimal emission rates.

As mStable is currently in the process of rapid restructuring and launching new pools, any comprehensive model we provide would risk being outdated short thereafter. Instead, we chose to use this MCCP to provide a simplified model as an example of the overall approach, which we intend to take in the longer term. We intend for such models to provide useful information, even after the governance of emission rates gets automated.

To this end, we consider \\(n\\) undifferentiated liquidity pools whose asset prices are stable in the long term, e.g. stablecoins.

### Assumptions

We assume that liquidity providers are drawn to pools with high annual percentage yield (APY), which is defined as in the following relation:

```
         yearly return on investment in USD
APY = ----------------------------------------
       initial value of the investment in USD
```

This value is computed from the combination of trading fees and liquidity mining rewards in each pool. Here, we assume that there is an equilibrium APY for each liquidity pool, tied to the corresponding market, below which the pool stops being attractive to liquidity providers. With this assumption, we imply that the APY does not fall below this minimum value.

We also assume that liquidity pool volume

- scales down linearly, when the pool is shrinking below current supply,
- and stays constant, when the pool is growing above current supply.

![](/assets/MCCP-4/volume_supply1.svg)

This is a conservative approach to estimating the demand in the market. It assumes that at a given point, the market is already saturated for a given liquidity pool, and increasing the liquidity will not necessarily increase volume. However, when the volume does increase at a future date, we take it into account by updating the values and rerunning the model.

However, if the demand curve for a given asset pair were already known, we could set a target volume and use the bonding curve to compute the target size of the pool. Then we could use those values in the model, instead of current volume and supply.

![](/assets/MCCP-4/volume_supply2.svg)

Our variables for the optimization problem are:

- \\(e_i\\): weekly emission to pool \\(i\\)
- \\(s_i\\): LP token supply (size) of pool \\(i\\)
- \\(v_i\\): total volume of pool \\(i\\)

The following are external parameters for the problem:

- \\(V_i\\): current weekly volume demanded from pool \\(i\\)
- \\(S_i\\): current LP token supply (size) of pool \\(i\\)
- \\(A_i\\): minimum APY for pool \\(i\\) (i.e. the equilibrium APY which the pool has at maximum size)
- \\(P\\): price of the governance token
- \\(P_i\\): price of the LP token of pool \\(i\\) (1 in the case of USD based pools)
- \\(e_\max\\): maximum total weekly emission
- \\(F\\): swap fee percentage, e.g. 0.0004

### Objective function

We are trying to maximize the TVL, which is simply the sum of the values of the LP tokens of all pools:

\\[
\text{maximize }
\sum_i P_is_i
\\]

### Constraints

**Constraint 1:** Total emission is less than or equal to maximum allowed emission.

\\[
\sum_i e_i \leq e_\max
\\]

**Constraint 2:** Pool APY should be greater than the designated minimum. The smaller the APY, the bigger the size of the pool.

\\[
52\left(\frac{FP_iv_i + Pe_i}{P_is_i}\right)
\geq A_i
\quad \text{for each } i
\\]

**Constraint 3:** Volume cannot be greater than current volume for each pool. This comes from the assumption we introduced above.

\\[
v_i \leq V_i
\quad \text{for each } i
\\]

**Constraint 4:** Volume scales down linearly when a pool shrinks below its current size.

\\[
v_i \leq \frac{V_i}{S_i} s_i
\quad \text{for each } i
\\]

Constraints 3 and 4 together create an envelope which enforce the assumption about volume's relationship with supply.

### Implementation

This is a standard [linear optimization](https://en.wikipedia.org/wiki/Linear_programming) problem and we use a common solver from the SciPy package for the implementation. We assume that all LP tokens have the price 1, that is, \\(P_i =1\\) for all \\(i\\).

```python
import numpy as np
from scipy.optimize import linprog

# Governance token price
P = 3.00

# Minimum APY
Ai = [0.10, 0.10, 0.10, 0.10, 0.10, 0.10]

# Current pool sizes
Si = [28e6, 10e6, 3e6, 3e6, 3e6, 3e6]

# Current weekly demanded volume
Vi = [15e6, 1e6, 0.5e6, 0.5e6, 0.5e6, 0.5e6]

# Maximum total emission
e_max = 150_000

# Swap fee percentage
F = 0.0004

# Solution
n = len(Ai) # Number of feeder pools
assert len(Ai) == len(Vi)

# Variables are:
# [s_1, ..., s_n, e_1, ..., e_n, v_1, ..., v_n]
c_vec = [1. for i in range(n)] \
    + [0. for i in range(2*n)]

c_vec = -1 * np.array(c_vec)

A_ub = []
b_ub = []

A_eq = []
b_eq = []

bounds = [(0, None) for i in range(3 * n)]

# Constraint: e + sum e_i <= e_max
lhs = [0. for i in range(n)] + [1. for i in range(n)] + [0. for i in range(n)]
rhs = e_max
A_ub.append(lhs)
b_ub.append(rhs)

# Constraints: (Ai)*Si - (52*P)*ei <= 52*F*Vi
for i in range(n):
    lhs = [0. for i in range(3*n)]
    lhs[i] = Ai[i]
    lhs[i+n] = -52 * P
    lhs[i+2*n] = -52 * F
    rhs = 0 #52*Vi[i]*F
    A_ub.append(lhs)
    b_ub.append(rhs)

# Constraint: v_i <= V_i
for i in range(n):
    lhs = [0. for i in range(3*n)]
    lhs[i+2*n] = 1
    rhs = Vi[i]
    A_ub.append(lhs)
    b_ub.append(rhs)

# Constraint: v_i <= s_i * (V_i / S_i)
for i in range(n):
    lhs = [0. for i in range(3*n)]
    lhs[i] = - Vi[i] / Si[i]
    lhs[i+2*n] = 1
    rhs = 0
    A_ub.append(lhs)
    b_ub.append(rhs)

A_ub = np.array(A_ub)
b_ub = np.array([b_ub])

sln = linprog(c_vec, A_ub=A_ub, b_ub=b_ub, bounds=bounds)
print(sln)

si = sln.x[:n]
ei = sln.x[n:2*n]
vi = sln.x[2*n:]

apy_i = [52*(F*v_+P*e_)/s_ for v_,e_,s_ in zip(vi, ei, si)]

if sln.status != 0:
    raise Exception("Solution was not successful")

print()
print("Resulting TVL: %.2fm"%(sum(si)/1e6))
for i in range(n):
    print("Pool %d emission: %.2f MTA - size: %.2fm - vol: %.2fm - APY: %.2f%%"%(
        i,
        ei[i],
        si[i]/1e6,
        vi[i]/1e6,
        100 * apy_i[i],
    ))
```

In this example, we have 6 liquidity pools with minimum APY of 10% each. Current pool sizes are 28m, 10m, 3m, 3m, 3m, 3m and current volumes are 15m, 1m, 0.5, 0.5, 0.5, 0.5 respectively. We don't need to input information regarding previous emissions, because that is considered implicitly with current volume `Vi` and current supply `Si`.

Governance token price is $3, maximum emission is 150,000 tokens and swap fee is 4 bps in all pools. The result of optimization is as follows:

```
Resulting TVL: 237.74m
Pool 0 emission: 21110.62 MTA - size: 36.05m - vol: 15.00m - APY: 10.00%
Pool 1 emission: 54329.26 MTA - size: 84.96m - vol: 1.00m - APY: 10.00%
Pool 2 emission: 18640.03 MTA - size: 29.18m - vol: 0.50m - APY: 10.00%
Pool 3 emission: 18640.03 MTA - size: 29.18m - vol: 0.50m - APY: 10.00%
Pool 4 emission: 18640.03 MTA - size: 29.18m - vol: 0.50m - APY: 10.00%
Pool 5 emission: 18640.03 MTA - size: 29.18m - vol: 0.50m - APY: 10.00%
```

The maximum TVL obtained with the current emission rates is around 237m.

<!-- @Onur Insert epic formulas etc here -->

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
