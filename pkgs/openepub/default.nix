{ python3, pkgs, fetchFromGitHub, lib }:
let
  owner = "sakolkar";
  repo = "openepub";
in
python3.pkgs.buildPythonPackage rec {
  pname = repo;
  version = "0.0.6";
  pyproject = true;

  src = fetchFromGitHub {
    inherit owner repo;
    rev = "9b5105c4b02b0b8f31aa51f69e9ed4aacadb32ee";
    sha256 = "0nz8iwyyhhwxq6a5f0xs6w1ggibvnc0mrzmlnc4kac4zc6wk7qy5";
  };

  nativeBuildInputs = with python3.pkgs; [
    hatchling
  ];

  propagatedBuildInputs = with python3.pkgs;
    [
      xmltodict
      beautifulsoup4
    ];

  meta = with lib; {
    changelog = "https://github.com/${owner}/${repo}/releases/tag/${version}";
    description = "Python library to interact with EPUB files.";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.bsd2;
  };
}
