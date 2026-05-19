# Proton Bridge for Termux
Build scripts for installing [Proton Mail Bridge](https://proton.me/mail/bridge) on Android via [Termux](https://termux.dev/).

### Instructions
  * Run `build.sh` to download, build, and install all dependencies (this will take ~15-30 mins and use around 2.5 GB of internal storage)
  * Once the build has completed, run `run.sh` to start the bridge server

### Notes
  * `build.sh` will set up a GPG keyring for Proton Bridge to use. To skip this step (e.g. to update Proton Bridge to a newer version), leave the name/email/comment fields blank. Any previously set up keys will be completely unaffected.
  * By default, this builds a [fork of Proton Bridge](https://github.com/mnixry/proton-bridge) that is modified to work with free accounts. It should work for paid ones too without modification, but this has not been tested.
  * To set up Proton Bridge:
    * Run it and type `login`. Follow prompts to log in
    * Wait for the sync to complete. This can take a long time
    * Type `i` to view server connection info (e.g. for setting up [Thunderbird Mobile](https://www.thunderbird.net/mobile/))
  * To ensure your phone doesn't kill the server to save battery, use the Termux session notification to acquire a wake lock.
