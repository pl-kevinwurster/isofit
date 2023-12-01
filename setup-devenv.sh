#!/bin/bash

# This script serves as a reference for how to set up a developer environment.
# Some packages, like GDAL, must be installed prior to running this script.
# On Ubuntu these packages are likely installed via '$ apt' or '$ apt-get',
# and on MacOS Homebrew is a common choice. Developers may want to use this
# script as a reference


set -x
set -o errexit
set -o pipefail
set -o nounset


VENV_PATH="venv"

if [ -e "${VENV_PATH}" ]; then
  echo "ERROR: Virtual environment already exists: ${VENV_PATH}"
  exit 1
fi

# Create virtual environment
python3 -m venv "${VENV_PATH}"

# This lets us install packages into the virtual environment without having to
# deal with ensuring it is active.
PYTHON3="${VENV_PATH}/bin/python3"
PIP="${PYTHON3} -m pip"

# Upgrade packaging dependencies. The presence of 'wheel' triggers a lot of the
# emerging Python packaging ecosystem changes.
${PIP} install pip setuptools wheel --upgrade

# Install the GDAL python package
.github/workflows/install-python-gdal.sh

# Install ISOFIT
${PIP} install -e ".[dev]"

# Install commit hooks
${PYTHON3} -m pre_commit install

# Download and unpack additional dependencies.
./download-and-unpack-sRTMnet.sh
./download-and-build-6s.sh
