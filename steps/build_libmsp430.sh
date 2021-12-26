#!/usr/bin/env bash
set -eu -o pipefail

trap "echo ❌ Failed to build libmsp430.so" ERR

cp hidapi/hidapi/hidapi.h mspds/ThirdParty/include
cp hidapi/libusb/hid.o mspds/ThirdParty/lib/hid-libusb.o
cp hidapi/libusb/hid.o mspds/ThirdParty/lib64/hid-libusb.o

cd mspds
make STATIC=1

sudo cp libmsp430.so /usr/lib/libmsp430.so

echo ✔️ Successfully built and installed libmsp430.so
