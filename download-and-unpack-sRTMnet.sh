#!/bin/bash


set -x
set -o errexit
set -o pipefail
set -o nounset


SRTMNET_DIR="sRTMnet_v100"
SRTMNET_FILENAME="sRTMnet_v100.zip"


# Just assume that if the target directory exists the data is downloaded and
# properly unpacked.
if [ -d "$SRTMNET_DIR" ]; then
  echo "Directory already exists - nothing to do: ${SRTMNET_DIR}"
  exit 0
fi


# Download sRTMnet file
mkdir "${SRTMNET_DIR}"
wget \
  --no-verbose \
  --directory-prefix "${SRTMNET_DIR}" \
  "https://zenodo.org/record/4096627/files/${SRTMNET_FILENAME}"


(
  cd "${SRTMNET_DIR}"
  unzip "${SRTMNET_DIR}"
  rm -rf "__MACOSX"
  rm -f .DS_Store sRTMnet_v100/.DS_Store
  rm "${SRTMNET_FILENAME}"
)
