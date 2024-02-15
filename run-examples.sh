#!/bin/bash


# Run selected examples.


set -x
set -o errexit
set -o pipefail
set -o nounset


# shellcheck disable=SC2164
# run 20151026_SantaMonica example
cd examples/20151026_SantaMonica
bash run_examples.sh

# run 20171108_Pasadena example
cd ../../examples/20171108_Pasadena
bash run_example_modtran.sh
python run_topoflux_example.py

# run 20190806_ThermalIR example
cd ../../examples/20190806_ThermalIR
python run_example_modtran_one.py

# run profiling_cube/small example
cd ../../examples/profiling_cube
ISOFIT_DEBUG=1 python run_profiling.py
