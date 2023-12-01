#!/bin/bash


# Run all linting-related commands. Also used by the CI system.


set -x
set -o pipefail
set -o nounset


EXIT_CODE=0

python3 -m black --check isofit/
if [ $? -ne 0 ]; then
  echo "ERROR: 'black' check failed"
  EXIT_CODE=1
fi

python3 -m isort --check-only isofit/
if [ $? -ne 0 ]; then
  echo "ERROR: 'isort' check failed"
  EXIT_CODE=1
fi


exit $EXIT_CODE
