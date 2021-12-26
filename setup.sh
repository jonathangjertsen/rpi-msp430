#!/usr/bin/bash
set -eu -o pipefail

trap "echo ❌ Something failed" ERR

$SHELL steps/download_mspds.sh
$SHELL steps/install_submodules.sh
$SHELL steps/install_apt_packages.sh
$SHELL steps/build_hidapi.sh
$SHELL steps/build_libmsp430.sh
$SHELL steps/verify.sh

echo ✔️ All OK
