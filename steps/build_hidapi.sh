#!/usr/bin/env bash
set -eu -o pipefail

trap "echo ❌ Failed to build HIDAPI" ERR

CONFIG_FILE="configure.ac"
cd hidapi
awk '!seen[$0]++ || $0 != "AC_CONFIG_MACRO_DIR([m4])"' "$CONFIG_FILE" > "$CONFIG_FILE.tmp" && mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"
echo "✔️ Successfully patched configure.ac"
./bootstrap || ./bootstrap # It installs ltmain.sh in the wrong place the first time, then it copies into the right folder the second time...
./configure
make
cd ..

echo "✔️ Successfully built HIDAPI"
