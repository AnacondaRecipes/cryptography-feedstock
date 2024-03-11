echo on

if [%PKG_NAME%] == [cryptography-vectors] (
  %PYTHON% -m pip install .\cryptography-vectors -vv --no-deps --no-build-isolation
  if errorlevel 1 exit 1
)

if [%PKG_NAME%] == [cryptography] (
  REM As of cryptography version 40.0.0, build instructions have changed: https://cryptography.io/en/latest/changelog/#v40-0-0
  REM here is the documentation on setting things manually, https://docs.rs/openssl/latest/openssl/#manual
  set OPENSSL_DIR=%LIBRARY_PREFIX%
  %PYTHON% -m pip install .\cryptography -vv --no-deps --no-build-isolation
  if errorlevel 1 exit 1
)