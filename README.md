This repo contains scripts that help with installing and running `mspdebug` on a Raspberry Pi.

It installs some packages via apt, and the rest from source.

To install, clone the repo and run `setup.sh`. Alternatively look into the `steps` folder to see each step that needs to be run.

Before running, please make sure apt is up to date by running e.g. `sudo apt install && sudo apt upgrade`

If it ran successfully, you can now run `mspdebug` with your board connected, and you should be able to run stuff.

Tested on: Raspberry Pi 4, Raspberry Pi 3 B+.
