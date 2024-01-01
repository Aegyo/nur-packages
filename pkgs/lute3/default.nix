{ python3
, pkgs
, lib
, fetchPypi
, natto-py
, openepub
}:

python3.pkgs.buildPythonPackage rec {
  pname = "lute3";
  version = "3.0.8";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    sha256 = "1a0fmnhcdywqr4lpqgsnqsvbmp1i5l1jcm7widra3ygvc3j3sywz";
  };

  patches = [
    (pkgs.fetchpatch {
      url = "https://github.com/Aegyo/lute-v3/commit/f2f93a208bd80be041b091342f3354746f9ff1cc.patch";
      sha256 = "1jna7mkisy7k6q279yqqmy1bmnf27q224bmjcgm6a5h4ja5jjhc9";
    })
  ];

  prePatch = ''
    cp lute/config/config.yml.prod lute/config/config.yml
  '';

  nativeBuildInputs = with python3.pkgs; [
    flit-core
  ];

  propagatedBuildInputs = with python3.pkgs; [
    flask-sqlalchemy
    flask-wtf
    natto-py
    jaconv
    platformdirs
    requests
    beautifulsoup4
    pyyaml
    toml
    waitress
    openepub
  ];

  meta = with lib; {
    changelog = "https://github.com/jzohrab/lute-v3/releases/tag/${version}";
    description = "LUTE = Learning Using Texts: learn languages through reading. Python/Flask.";
    homepage = "https://github.com/jzohrab/lute-v3";
    license = licenses.mit;
  };
}
