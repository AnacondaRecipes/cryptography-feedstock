#!/bin/bash

set -exuo pipefail

echo "Building ${PKG_NAME}."

if [[ "${PKG_NAME}" == "cryptography-vectors" ]]; then
    $PYTHON -m pip install ./cryptography-vectors -vv --no-deps --no-build-isolation
elif [[ "${PKG_NAME}" == "cryptography" ]]; then
    # As of cryptography version 40.0.0, build instructions have changed: https://cryptography.io/en/latest/changelog/#v40-0-0
    # here is the documentation on setting things manually, https://docs.rs/openssl/latest/openssl/#manual
    export OPENSSL_DIR=$PREFIX
    $PYTHON -m pip install ./cryptography -vv --no-deps --no-build-isolation
fi