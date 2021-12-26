#!/usr/bin/env bash
set -eu -o pipefail

trap "echo ❌ Failed to install APT packages" ERR

DEBIAN_FRONTEND=noninteractive sudo apt-get install -y libboost1.67-all-dev libusb-1.0 libudev-dev mspdebug

echo ✔️ Successfully installed APT packages
