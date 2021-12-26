#!/usr/bin/bash
set -eu -o pipefail

trap "echo ❌ Failed to download MSPDS" ERR

curl -L https://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPDS/3_15_1_001/export/MSPDebugStack_OS_Package_3_15_1_1.zip --output mspds.zip
unzip -q -o mspds.zip -d mspds

echo ✔️ Successfully downloaded MSPDS
