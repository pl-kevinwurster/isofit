#!/bin/bash


# NOTE: Be careful about executing this script outside of a virtual environment.
#       The CI setup appears to invoke outside of a virtual environment, but it
#       is in fact operating in isolation. Users attempting to invoke this
#       script to set up a developer environment should consult the associated
#       documentation.


set -x
set -o errexit
set -o pipefail
set -o nounset


# Ensure we are pointing to a consistent version of 'pip'.
PIP="python3 -m pip"

# The current GDAL install situation is difficult:
#   https://github.com/OSGeo/gdal/issues/8069
# Ultimately, Numpy must be installed first, and then 'gdal'. It is
# not practical to extract 'isofit's actual Numpy dependency from the
# package metadata, so for now we must just manually match this
# dependency. 'pip' also does not guarantee that packages will be
# installed in any specific order, so we really **must** manually
# install it first. It is possible that this version of 'numpy' will
# be uninstalled in order to match 'isofit's listed 'numpy'
# dependency, but this seems to not matter given how 'gdal' uses
# 'numpy'.
$PIP install "numpy>=1.20"

# It is possible to successfully install the 'gdal' package without
# installing 'numpy', which puts the package in a state where it is
# effectively unusable for this project. See this issue for info:
#   https://github.com/OSGeo/gdal/issues/8069
# 'pip' v23 removed some features, but this command should work on
# both recent versions, and the new world of 'pyproject.toml' based
# installations. It may require some alterations if GDAL makes changes
# to how the 'gdal' package is installed.
# Notes about flags:
#   --force-reinstall     If GDAL is not built correctly and cached,
#                         subsequent builds will discover the cached
#                         version and not rebuild. This is a sensitive
#                         package, so just always force reinstall.
#   --no-cache-dir        See note about '--force-reinstall'.
#   --no-build-isolation  'pip' builds packages in isolation, and
#                         this environment only has access to packages
#                         listed in 'setup_requires'. 'gdal' does not
#                         list 'numpy' in 'setup_requires', so we must
#                         manually install it, and disable isolation
#                         to allow it to be imported when the package
#                         is built.
$PIP install \
  --force-reinstall \
  --no-cache-dir \
  --no-build-isolation \
  "gdal==$(gdal-config --version)"

# Ensure that the 'gdal' Python package was installed correctly. This
# command will fail with an error about how 'osgeo._gdal_array' is
# missing if something is wrong.
python3 -c "from osgeo import gdal_array"
