#!/usr/bin/bash
set -eu -o pipefail

trap "echo ❌ Failed to install git submodules" ERR

git submodule init
git submodule update

echo ✔️ Successfully installed git submodules
