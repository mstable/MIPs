---
mip: 24
title: Emission Controller
status: Proposed
author: Dimitri Golecko (@dimsome), Nick Addison (@naddison36)
discussions-to:
created: 2021-11-24
---

```
---
mip: 24
title: Emissions Controller
status: WIP
author: Dimitri Golecko (@dimsome), Nick Addison (@naddison36)
discussions-to:
created:
---

```

## Simple Summary

It is proposed to move the manual weekly distribution of MTA emission based on the calculation specified in [MCCP 4](../mccp/mccp-4) and consequently updated by [MCCP 7](../mccp/mccp-7), [MCCP 8](../mccp/mccp-8), [MCCP 9](../mccp/mccp-9) and [MCCP 10](../mccp/mccp-10) to an on-chain Emissions Controller that determines the distribution of MTA to vaults and other recipient contracts via votes on dials by MTA stakers. Dials are representations of votes towards a destination within the Emissions Controller contract. Additionally, the topline MTA emission schedule is proposed here and fully controlled by the Emissions Controller smart contracts going forward. MTA stakers are incentivised to allocate the rewards towards the dials that yields the highest return in order to maximise protocol revenue.

## Abstract

To further progress mStable’s decentralisation and to add more value to the MTA token, it is proposed that the weekly MTA rewards will be moved to an on-chain governance platform that allows MTA stakers, or their delegated account, to decide where MTA rewards are directed each week. This builds on the Staking V2 contract introduced with [MIP 15](./mip-15) and uses its voting power and voter delegation system. Governance votes can direct the ProtocolDAO to add new pools and products or to disable any dial that is chosen not to continue to receive any rewards.

The MTA Emissions Controller will distribute weekly MTA rewards in accordance with the votes of the MTA stakers. This is similar to [Curve’s GaugeController](https://dao.curve.fi/gaugeweight). This will also lock in a topline and a long-term emission schedule of MTA: 30 Million MTA will be distributed over the next 6 years starting from the first distribution on the 16th \***\*December 2021**.\** Before the first distribution, more than a week will be given to allocating the first votes. This would leave over 5.1 Million MTA in the Treasury. The emission schedule follows a polynomial curve and is further detailed in section: *Specification - MTA emission schedule\*.

This would also change the reward allocation of protocol revenue. Whereas previously the protocol revenue was diverted to the Buyback&Make pool as specified in [MIP 8](./mip-8), the protocol revenue now gets directed to the two staking contracts proportionally. This would have the effect that stakers are incentivised to allocate MTA rewards towards dials that generate the highest protocol revenue. As part of this update, the Buyback&Make Pool gets sunsetted. The accrued amount will be transferred to the TreasuryDAO and is therefore in the hands of all MTA holders to either continue to provide liquidity or to allocate differently with a future TDP (Treasury DAO Proposal).

## Motivation

Previously, MTA rewards allocation was determined by Governance processes and by proposals to establish a distribution scheme. Such was the [MCCP 4](../mccp/mccp-4) that attempted to algorithmically allocate rewards to Feeder Pools based on TVL and Volume. This resulted in a suboptimal allocation in which pools that contributed not much to the protocols revenue still received a substantial share of MTA emissions. Consequently, this approach would also mean that any pools that are not included in this proposal would have needed their own proposal to carve out a certain amount for a different use case. This resulted in a high amount of proposals which all had ample time to pass through the governance instances. Additionally, the emission of MTA needed a further and constant reduction. This was dealt with mainly new proposals to adjust topline emissions. However, this is not a good long-term solution, since it requires continuous adjustments and does not provide a way to anticipate emission for a given future point in time.

This new Emissions Controller solves these problems:

1. MTA rewards can be allocated by governance on a weekly basis without passing governance proposals, resulting in faster reaction time.
2. MTA Governors are incentivised to allocate the MTA rewards to maximise the protocol revenue and maximise system network effects through the buyback.
3. Decentralise the protocol further by allowing MTA Governors to allocate the MTA emissions directly.
4. Increase the value of holding and staking MTA, since the emissions can be directly influenced.
5. Gives other projects a stake which should result in more demand for MTA.

The automation of this process would also allow for a more streamlined process and reduce workload for the core contributors allowing more time to focus on building new products. This would also mean that the protocol is further decentralising by giving MTA stakers direct control over MTA distribution.

## Specification

### MTA emission schedule

It is proposed to distribute 30 Million MTA over 6 years starting from 16th \***\*December 2021. The existing MTA emissions will continue until the 16th \*\***December 2021 and then be replaced by the Emissions Controller. The 30 Million MTA leaves over 5.1 Million MTA in the TreasuryDAO that is available for usage with future TDPs.

The weekly distribution schedule of the 30 Million MTA is defined by a polynomial equation. This will quickly reduce the amount of MTA being distributed each week, slow down the reduction in the middle and then accelerate the reduction of distributed rewards at the end in order to end at 0 by the last epoch.

The following formula is used to determine the distribution for a given epoch `x`.

$$
f(x)=A*(x/div)^3+B*(x/div)^2+C*(x/div)+D


$$

with the parameter:

- `A = 1.66E+17`
- `B = 168479942061125000`
- `C = -168479942061125000`
- `D = 1.66E+17`
- `div = 312000000`

The length of an epoch is defined as one week and is equal to the distribution frequency. This distribution schedule is for a total of 312 epochs or roughly 6 years.

![Screen Shot 2021-11-23 at 23.32.37.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/15d563b5-ef57-4d9a-afde-565bf2bb9bce/Screen_Shot_2021-11-23_at_23.32.37.png)

### Dials

Dials determine the amount of the MTA rewards that are sent to a dial’s recipient contract.

A dial recipient can be any contract that can either receive MTA tokens or can be notified of the amount of received rewards so the contract can account for it. Dials can be added and removed via governance votes. The set of the initial dials are the following:

```markdown
| Dial                            | Description                               |
| ------------------------------- | ----------------------------------------- | --- | ------------- | -------------------------------- |
| Staking MTA                     | Staking Contract for MTA                  |
| Staking mBPT                    | Staking Contract for Balancer Pool Tokens |
| imUSD Vault                     | SAVE Vault for mUSD                       |
| imBTC Vault                     | SAVE Vault for mBTC                       |
| GUSD fPool                      | mUSD/GUSD Feeder Pool                     |
| BUSD fPool                      | mUSD/BUSD Feeder Pool                     |
| alUSD fPool                     | mUSD/alUSD Feeder Pool                    |
| RAI fPool                       | mUSD/RAI Feeder Pool                      |
| FEI fPool                       | mUSD/FEI Feeder Pool                      |
| HBTC fPool                      | mBTC/HBTC Feeder Pool                     |
| TBTC fPool (v2)                 | mBTC/TBTCv2 Feeder Pool                   |
| p-imUSD Vault                   | SAVE Vault for mUSD on Polygon            |
| p-FRAX fPool                    | mUSD/FRAX Feeder Pool on Polygon          |
| p-Balancer WMATIC/MTA/WETH pool | Balancer 40/40/20 WMATIC/MTA/WETH Pool    |     | Visor finance | Visor finance Uniswap v3 MTA/ETH |
| OlympusPro bonds                | OlympusPro Custom Treasury Contract       |
| mStable DAO Treasury            | mStable Treasury donate Dials             |
```

### Voting Power

Votes for dials come from the voting power in the recently deployed [Staking V2 contracts](https://medium.com/mstable/staking-v2-2cd864552130).
Voting power can be acquired by staking MTA, mBPT or by another staker delegating their voting power to another account. If a user has delegated their voting power but now wants their voting power back they can remove the delegation of voting power at any point.

Initially, all the existing contracts that receive MTA rewards will be open up for voting. After a two week voting period, the old MTA reward distribution will be stopped and the new MTA distribution based on staker votes will commence.

### **Weighting votes across dials**

Accounts with voting power can proportion their voting power across the configured dials. This can be 100% on just one dial. Or could be a little to each dial. The more dials that are voted on the more gas is required when changing voting power in the staking contracts. eg staking, withdrawing or changing delegation.

Once the voting weights across the dials are set, this will be used for each weekly distribution until the weights are changed. That is, voters don’t need to spend gas every week if their weighting of voting power across the dials remains the same every week.

The emissions controller will maintain the weighted votes for each dial. If a voter’s voting power changes, then the dial weight will be updated. This can be from staking, withdrawing or changes to delegation. Further, a change in multipliers as specified in [MIP 15: Staking V2](./mip-15) will also automatically increase the weighted voting power to dials according to the chosen allocation proportion.

To prevent voters from just giving all the MTA to themselves, each staking contract will up to 10% of the MTA distributions each week. There are currently two staking contracts so a maximum of 20% of the MTA rewards goes to the stakers.

To generate more value for the MTA holders, the Protocol revenue will be used to buy MTA and distribute to stakers. This incentivises the voters to maximise the protocols revenues.

There is no cap on the amount of MTA a dial that is not a staking contract can receive. So all the voting power could be put on just one dial. This is unlikely to happen as it would require over 200 stakers to collude.

### **Donations**

The emissions controller will allow anyone to donate MTA rewards to a dial that is in addition to the weekly emissions schedule. These additional MTA rewards will be included in the weekly distribution. This can be used by mStable or third parties to incentivize dials.

### **Polygon Integration**

Polygon’s [Proof of Stake (PoS) Bridge](https://docs.polygon.technology/docs/develop/ethereum-polygon/pos/getting-started) will be used by the Emissions Controller to send MTA to the existing [child MTA](https://polygonscan.com/token/0xF501dd45a1198C2E1b5aEF5314A68B9006D842E0) token on Polygon. This will be done indirectly using a dial recipient contract that interfaces with the PoS Bridge.

MTA rewards can be sent directly to the dial contract on Polygon. eg FRAX. Or MTA rewards can be sent via the L2 Emissions Controller which will notify the recipient contract that the rewards have been transferred. eg the imUSD Vault on Polygon.

Voting can not be done on Polygon. All voting of dials is done on Ethereum mainnet.

### **Weekly Distribution**

The weekly distribution of the MTA rewards will be done in two transactions

1. The amount of MTA rewards for each dial is calculated
   1. calculate the amount of MTA rewards to be distributed for the week.
   2. calculate the total weight votes across all dials that have not been disabled.
   3. calculate the MTA rewards for each dial that has not been disabled
2. Transfer MTA rewards to specified dials and optionally notify. This can be broken down into a smaller number of transactions depending on gas usage.
   1. Transfers the previously calculated MTA rewards plus any donated MTA to the specified dial recipient contracts.
   2. If the dial is configured for notifications, the dial is notified of the distributed MTA amount so it can process the received MTA.

The weekly distributions can be run after Thursday, 00:00am UTC time.

It’s possible the MTA rewards can be calculated but not transferred. Each new calculated reward will just be added to any undistributed MTA rewards so when the distribution is eventually run all MTA rewards will be distributed.

## Technical Specification

### Buyback & Make

Since the accrued MTA revenue will go proportionally directly to MTA stakers, the Buyback & Make pool will be no longer used for depositing protocol fees. The total amount of accrued Balancer Pool Tokens and BAL rewards will be transferred to the TreasuryDAO:

- Call `migrate(0x3dd46846eed8D147841AE162C8425c08BD8E1b41)` on the [Revenue Recipient contract](https://etherscan.io/address/0xA7824292efDee1177a1C1BED0649cfdD6114fed5)

### Contract Overview

At the base of this functionality is the contract `EmissionsController.sol` This contract holds the data for all the dials, voting weight for each dial and calculates and distributes the amount of the reward based on the cumulative voting weights.

Separately, each dial recipient that is situated on L2s or Polygon needs to have their contract on mainnet. An instance of the `BridgeForwarder.sol` can be deployed for every such dial, e.g. imUSD, mUSD/FRAX Feeder Pool and Balancer Pool on Polygon will have their own instance of this contract.

Additional dials that are outside of the mStable's protocol smart contracts can be implemented via the contract `BasicRewardsForwarder.sol`. This contract acts as the recipient of a standardized reward and forwards the received rewards to a destination contract. This contract can be deployed with a third-party protocol as the owner. The owner can change the `endRecipient` in case the smart contracts are updated.

### Polygon Integration

Each dial that is on polygon will receive its representation on Ethereum mainnet. The `BridgeForwarder.sol` will be deployed on for the following dials with the following parameters:

- p-imUSD vault
- p-mUSD/FRAX Feeder Pool
- p-Balancer WMATIC/MTA/WETH pool

The `BridgeForwarder.sol` will be called by the Emissions Controller via `function notifyRewardAmount()`. This will trigger the `depositFor()` on the [Root Chain Manager](https://etherscan.io/address/0xA0c68C638235ee32657e8f720a23ceC1bFc77C77), which is an existing Polygon contract that is used to bridge tokens between Mainnet and Polygon. The result is that MTA will be bridged over to Polygon and deposited into the contract `L2BridgeRecipient.sol`. For each dial on Polygon a separate instance will be deployed. A second contract `L2EmissionController.sol` has permission to transfer the MTA tokens and distribute them to the designated vaults via `function distributeRewards()`. Governance can add additional dials to the Polygon implementation.

![MTA Emission](../assets/MIP-24/emission.png)

### Emissions Controller

An Instance of the `EmissionsController.sol` will be deployed with the following constructor arguments:

- `nexus = 0xAFcE80b19A8cE13DEc0739a1aaB7A028d6845Eb3` (Nexus Contract)
- `rewardToken = 0xa3BeD4E1c75D00fa6f4E5E6922DB7261B5E9AcD2` (MTA Token)
- `TopLevelConfig = {A: -166000, B: 180000, C: -180000, D: 166000, EPOCHS: 312 }` (Polynomial Distribution)

The contract will be initialised with the following parameters (for `address[] memory _recipients, uint8[] memory _caps, bool[] memory _notifies`). These are the initial dials that are proposed here:

```markdown
| recipients                                 | caps | notifies |
| ------------------------------------------ | ---- | -------- |
| 0x8f2326316eC696F6d023E37A9931c2b2C177a3D7 | 10   | true     |
| 0xeFbe22085D9f29863Cfb77EEd16d3cC0D927b011 | 10   | true     |
| 0x78BefCa7de27d07DC6e71da295Cc2946681A6c7B | 0    | true     |
| 0xF38522f63f40f9Dd81aBAfD2B8EFc2EC958a3016 | 0    | true     |
| 0xAdeeDD3e5768F7882572Ad91065f93BA88343C99 | 0    | true     |
| 0xD124B55f70D374F58455c8AEdf308E52Cf2A6207 | 0    | true     |
| 0x0997dDdc038c8A958a3A3d00425C16f8ECa87deb | 0    | true     |
| 0x97E2a2F97A2E9a4cFB462a49Ab7c8D205aBB9ed9 | 0    | true     |
| 0xF65D53AA6e2E4A5f4F026e73cb3e22C22D75E35C | 0    | true     |
| 0xF3f4F4e17cC65BDC36A36fDa5283F8D8020Ad0a4 | 0    | false    |
```

In addition, the following recipients will be deployed and added after the respective bridges/vaults are deployed:

```markdown
| recipients                                           | caps | notifies |
| ---------------------------------------------------- | ---- | -------- |
| BasicRewardsForwarder.sol: mStable DAO Treasury      | 0    | true     |
| BasicRewardsForwarder.sol: OlympusPro bonds          | 0    | true     |
| BoostedDualVault.sol: RAI fPool Vault                | 0    | true     |
| BoostedDualVault.sol: FEI fPool Vault                | 0    | true     |
| BridgeForwarder.sol: p-imUSD Vault                   | 0    | true     |
| BridgeForwarder.sol: p-FRAX fPool                    | 0    | true     |
| BridgeForwarder.sol: p-Balancer WMATIC/MTA/WETH pool | 0    | true     |
```

For the staking contract `BridgeForwarder.sol` the corresponding `L2BridgeRecipient.sol` will be deployed on Polygon along with adding these to the `L2EmissionsController.sol` via `function addRecipient()`.

The initial `_stakingContracts` are the two staking contracts proposed in [MIP 15: Staking V2](https://mips.mstable.org/MIPS/mip-15.html):

- `MTAStakingAddress: 0x8f2326316eC696F6d023E37A9931c2b2C177a3D7`
- `mBPTStakingAddress: 0xeFbe22085D9f29863Cfb77EEd16d3cC0D927b011`

These two staking contracts are set to determine the distribution.

**Function:**

- `function topLineEmission()` Calculates top line distribution amount for the current epoch (see section Specifications - MTA emission schedule).
- `function addDial()` adds a new dial that can be voted on to receive weekly rewards. Callable by ProtocolDAO multisig after governance approval.
- `function updateDial()` Updates a dials recipient contract or disabled flag. Callable by ProtocolDAO multisig after governance approval.
- `function donate()` allows arbitrary reward donation to a dial on top of the weekly rewards.
- `function calculateRewards()` Calculates the rewards to be distributed to each dial for the next weekly period. Can be called by anyone once an epoch has fully passed.
- `function distributeRewards()` Transfers all accrued rewards to dials and notifies them of the amount.
- `function pokeSources()` Re-cast a voters votes by retrieving balance across all staking contracts and updates it.
- `function setVoterDialWeights()` Allows a staker to cast their voting power across a number of dials. A maximum of 16 dials can be set.
- `function moveVotingPowerHook()` Called by the staking contract to update the votes. Called when staking, cooling down or delegating votes.

Dials can be added and removed via governance vote (see Configurable Values (Via MCCP))

### Configurable Values (Via MCCP)

New dials can be added or disabled by Governance:

- `function addDial()` To create a new dial that can be voted upon.
- `function updateDial()` To update a dial recipient contract or to disable the dial.

For new dials on Polygon the following configurations are necessary:

- `function addRecipient()` called on the contract `L2EmissionController.sol`
- A new instance of `L2BridgeRecipient.sol` to be deployed

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
