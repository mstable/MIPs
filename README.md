# MIPs
mStable Improvement Proposals (MIPs) describe standards for the mStable platform, including core protocol specifications, client APIs, and contract standards.

WIP: A browsable version of all current and draft MIPs can be found on [the official MIP site](https://mips.mstable.org/).

# Contributing

 1. Review [MIP-1](MIPS/mip-1.md).
 2. Fork the repository by clicking "Fork" in the top right.
 3. Add your MIP to your fork of the repository. There is a [template MIP here](mip-X.md).
 4. Submit a Pull Request to mStable's [MIPs repository](https://github.com/mstable/MIPs).

Your first PR should be a first draft of the final MIP. It must meet the formatting criteria enforced by the build (largely, correct metadata in the header). An editor will manually review the first PR for a new MIP and assign it a number before merging it. Make sure you include a `discussions-to` header with the URL to a new thread on [forum.mstable.org](https://forum.mstable.org) where people can discuss the MIP as a whole.

If your MIP requires images, the image files should be included in a subdirectory of the `assets` folder for that MIP as follow: `assets/mip-X` (for mip **X**). When linking to an image in the MIP, use relative links such as `../assets/mip-X/image.png`.

When you believe your MIP is mature and ready to progress past the WIP phase, you should ask to have your issue added to the next governance call where it can be discussed for inclusion in a future platform upgrade. If the community agrees to include it, the MIP editors will update the state of your MIP to 'Approved'.

# MIP Statuses

* **WIP** - a MIP that is still being developed.
* **Proposed** - a MIP that is ready to be reviewed in a governance call.
* **Approved** - a MIP that has been accepted for implementation by the mStable community.
* **Implemented** - a MIP that has been released to mainnet.
* **Rejected** - a MIP that has been rejected.


# Validation

MIPs must pass some validation tests.  The MIP repository ensures this by running tests using [html-proofer](https://rubygems.org/gems/html-proofer) and [mip_validator](https://rubygems.org/gems/mip_validator).

It is possible to run the MIP validator locally:
```
gem install mip_validator
mip_validator <INPUT_FILES>
```


# Automerger

The MIP repository contains an "auto merge" feature to ease the workload for MIP editors.  If a change is made via a PR to a draft MIP, then the authors of the MIP can Github approve the change to have it auto-merged by the [mip-automerger](https://github.com/bakaoh/mip_automerger) bot.
