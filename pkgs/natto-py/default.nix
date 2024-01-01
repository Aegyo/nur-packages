{ python3, pkgs, fetchFromGitHub, lib }:
let
  owner = "buruzaemon";
  repo = "natto-py";
in
python3.pkgs.buildPythonPackage rec {
  pname = repo;
  version = "1.0.1";

  src = fetchFromGitHub {
    inherit owner repo;
    rev = version;
    sha256 = "0zz5fz2mkkndkj4xz8qlnd7akmiz8322141jf49znm8djfziichv";
  };

  nativeCheckInputs = with python3.pkgs; [
    pkgs.mecab
  ];

  preCheck = ''
    export MECAB_PATH=$(mecab-config --libs-only-L)/libmecab.so
    export MECAB_CHARSET=utf8
  '';

  propagatedBuildInputs = with python3.pkgs;
    [
      pkgs.mecab
      pyyaml
      cffi
    ];

  meta = with lib; {
    changelog = "https://github.com/${owner}/${repo}/releases/tag/${version}";
    description = "natto-py combines the Python programming language with MeCab, the part-of-speech and morphological analyzer for the Japanese language.";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.bsd2;
  };
}
