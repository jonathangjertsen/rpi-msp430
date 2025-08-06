This repo contains scripts that help with installing and running `mspdebug` on a Raspberry Pi.

It installs some packages via apt, and the rest from source.

## Automated setup

Before running, please make sure apt is up to date by running e.g. `sudo apt install && sudo apt upgrade`

To install, clone the repo and run `setup.sh`. Alternatively look into the `steps` folder to see each step that needs to be run.

If it ran successfully, you can now run `mspdebug` with your board connected, and you should be able to run stuff.

Tested on: Raspberry Pi 5 with TI MSP-FET and MSP430FG2618, and with Raspberry Pi 4 / Raspberry Pi 3 B+ using an MSP-EXP430FR2355 board.

## Details

This repo exists because I wanted to use a Raspberry Pi as a self-hosted runner to run unit tests
on an MSP430 board using Github Actions.

TI provides a few ways to flash MSP430 boards, including [Code Composer Studio][CCS], [MSPFLASHER][MSPFlasher] and [Uniflash][Uniflash]. All of these are available for Linux, but none of them are available for ARM processors like the Raspberry Pi.

One tool that is supported is Daniel Beer's [mspdebug][mspdebug], which we can simply `apt-get install`. However, it needs an externally provided driver to connect to. After some staring at the manpage, it seemed like `tilib` would be a good choice. The name means that it uses a TI-provided dynamic library called `libmsp430.so`, which is part of TI's [MSP Debug Stack][mspds]. Once again, a prebuilt binary is available for Linux, but not for ARM.

This time, though, TI has actually provided the source code, so we can build it ourselves. First, we need to download and extract the MSPDS source files. This is done in the `steps/downloads_mspds.sh` script.

`libmsp430.so` has a couple of its own dependencies: [Boost][boost] version 1.67, and [HIDAPI][hidapi] version 0.8.0-rc1.

Boost is fortunately just an `apt-get install libboost1.67-all-dev` away.
I couldn't get the same to work with HIDAPI, but it's reasonably easy to build from source (see `steps/build_hidapi.sh` in this repo). The only quirk I saw was that the bootstrap script had to run twice.

Now for the tricky bit. According to the build instructions, MSPDS expects some of the artifacts from HIDAPI to be copied over to a folder called `ThirdParty`. The instructions say to copy `hidapi.h` into `ThirdParty/include`, and to copy `hid-libusb.o` into `ThirdParty/lib`. Now, I couldn't find any files called `hid-libusb.o` in the build folder, so I just tried the closest sounding thing which was `libusb/hid.o`. I copied this file into `ThirdParty/lib` and renamed it to `hid-libusb.o`. I also had to copy it to `ThirdParty/lib64`.

As awkward as all that sounds, it works: I just ran `make STATIC=1` in the MSPDS root directory, and after several minutes I had a `libmsp430.so`. The final step was to copy it over to `/usr/lib/` so `mspdebug` could find it.

The last step is to verify that it works. For example, `mspdebug tilib --usb-list` should show that a board is connected. You can then run just `mspdebug` to start an interactive shell, or do whatever you need to do from the command line (refer to the manpage for that).

[CCS]: https://www.ti.com/tool/CCSTUDIO
[MSPFlasher]: https://www.ti.com/tool/MSP430-FLASHER
[Uniflash]: https://www.ti.com/tool/UNIFLASH
[mspdebug]: https://dlbeer.co.nz/mspdebug/
[mspds]: https://www.ti.com/tool/MSPDS
[boost]: https://www.boost.org/
[hidapi]: https://github.com/signal11/hidapi
