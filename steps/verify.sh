#!/usr/bin/env bash
set -eu -o pipefail

trap "echo ❌It didn't work..." ERR

mspdebug tilib --usb-list

echo ✔️ It seems to work
