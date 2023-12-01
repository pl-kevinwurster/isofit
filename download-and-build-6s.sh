#!/bin/bash


set -x
set -o errexit
set -o pipefail
set -o nounset


SIXS_DIR="6sv-2.1"

mkdir -p "${SIXS_DIR}"
cd "${SIXS_DIR}"
wget https://github.com/ashiklom/isofit/releases/download/6sv-mirror/6sv-2.1.tar

tar -xf 6sv-2.1.tar

cp Makefile Makefile.bak
sed -i -e 's/FFLAGS.*/& -std=legacy/' Makefile

make -j "$(nproc)"
