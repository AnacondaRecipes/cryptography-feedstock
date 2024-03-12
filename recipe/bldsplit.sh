#!/bin/bash

set -exuo pipefail

echo "Building ${PKG_NAME}."

if [[ "${PKG_NAME}" == "cryptography-vectors" ]]; then
    $PYTHON -m pip install ./cryptography-vectors -vv --no-deps --no-build-isolation
elif [[ "${PKG_NAME}" == "cryptography" ]]; then
    # As of cryptography version 40.0.0, build instructions have changed: https://cryptography.io/en/latest/changelog/#v40-0-0
    # here is the documentation on setting things manually, https://docs.rs/openssl/latest/openssl/#manual
    export OPENSSL_DIR=$PREFIX
    # setuptools-rust 1.9.0 has py-limited-api set to auto by default
    # this seem to not play well with our build, resulting with the py38 package rust binding to use python API introcuded in python 3.9
    # https://setuptools-rust.readthedocs.io/en/v1.9.0/building_wheels.html#building-for-abi3
    $PYTHON -m pip install ./cryptography -vv --no-deps --no-build-isolation --global-option=--build-option=--py-limited-api=cp${PY_VER//./}
fi