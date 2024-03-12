echo on

if [%PKG_NAME%] == [cryptography-vectors] (
  %PYTHON% -m pip install .\cryptography-vectors -vv --no-deps --no-build-isolation
  if errorlevel 1 exit 1
)

if [%PKG_NAME%] == [cryptography] (
  REM As of cryptography version 40.0.0, build instructions have changed: https://cryptography.io/en/latest/changelog/#v40-0-0
  REM here is the documentation on setting things manually, https://docs.rs/openssl/latest/openssl/#manual
  set OPENSSL_DIR=%LIBRARY_PREFIX%
  REM setuptools-rust 1.9.0 has py-limited-api set to auto by default
  REM this seem to not play well with our build, resulting with the py38 package rust binding to use python API introcuded in python 3.9
  REM https://setuptools-rust.readthedocs.io/en/v1.9.0/building_wheels.html#building-for-abi3
  set PY_VER_ND=%PY_VER:.=%
  %PYTHON% -m pip install .\cryptography -vv --no-deps --no-build-isolation --global-option=--build-option=--py-limited-api=cp%PY_VER_ND%
  if errorlevel 1 exit 1
)