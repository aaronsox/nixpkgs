{ lib
, buildPythonPackage
, fetchPypi
, pythonOlder
, pythonRelaxDepsHook
, hatchling
, hatch-fancy-pypi-readme
, grpcio
, protobuf
, googleapis-common-protos
, pydantic
, requests
, aiohttp
, packaging
, opentelemetry-sdk
}:

buildPythonPackage rec {
  pname = "xai-sdk";
  version = "1.7.0";
  pyproject = true;
  disabled = pythonOlder "3.10";

  src = fetchPypi {
    pname = "xai_sdk";
    inherit version;
    hash = "sha256-ZJ58O/8BUQMm8Tpwnf+CQlb839KFDiFgbSWHAgiYm9E=";
  };

  nativeBuildInputs = [
    pythonRelaxDepsHook
    hatchling
    hatch-fancy-pypi-readme
  ];

  pythonRelaxDeps = [ "opentelemetry-sdk" ];

  propagatedBuildInputs = [
    grpcio
    protobuf
    googleapis-common-protos
    pydantic
    requests
    aiohttp
    packaging
    opentelemetry-sdk
  ];

  dontUsePytestCheck = true;

  pythonImportsCheck = [ "xai_sdk" ];

  meta = with lib; {
    description = "Official Python SDK for the xAI API (gRPC client)";
    homepage = "https://github.com/xai-org/xai-sdk-python";
    changelog = "https://github.com/xai-org/xai-sdk-python/blob/main/CHANGELOG.md";
    license = licenses.asl20;
    maintainers = with maintainers; [ aaronsox ];
    platforms = platforms.unix;
  };
}
