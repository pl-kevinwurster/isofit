#!/bin/bash


# Drop-in replacement for '$ pytest' that sets some environment variables.
# Also used by the CI system.


set -x
set -o errexit
set -o pipefail
set -o nounset


# Use absolute file paths for environment variables. Note that
# 'EMULATOR_PATH' is not actually a filepath, so have to be a bit
# more clever. Could possibly use the 'pytest-env' to make life better
# for developers, and set this in 'pytest.ini'.
EMULATOR_PATH="$(pwd)/sRTMnet_v100/sRTMnet_v100" \
SIXS_DIR=$(realpath 6sv-2.1) \
python3 -m pytest "$@"
