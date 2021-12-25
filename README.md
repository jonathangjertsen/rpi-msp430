Most things will need to be compiled from source.

- Get MSPDebug
  - `sudo apt-get install mspdebug` (available from apt)
  - mspdebug has a runtime dependency on `libmsp430.so`, which we need to compile from source.
      - Get the source code from https://www.ti.com/tool/MSPDS, download to a folder called `mspds`
      - Get the dependencies:
        - Boost (available from apt)
          - `sudo apt-get install boost-1.67`
        - hidapi (built from source)
          - Clone https://github.com/signal11/hidapi
          - Get dependencies:
            - `sudo apt-get install libusb-1.0 libudev-dev`
          - `cd hidapi`
          - `./bootstrap`
          - `./configure`
          - `make`
        - Copy files from hidapi to mspds
          - `cp hidapi/hidapi.h mspds/ThirdParty/include`
          - `cp hidapi/libusb/hid.o mspds/ThirdParty/lib/hid-libusb.o`
     - `cd mspds`
     - `make`
     - `sudo cp libmsp430.so /usr/lib`
`mspdebug tilib`
