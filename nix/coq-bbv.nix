{
  lib,
  rocqPackages,
  stdlib,
  coq
}:

rocqPackages.mkRocqDerivation {
  pname = "coq-bbv";
  version = "v1.6";
  release  = {
    "v1.6".hash = "sha256-a0z2v5F8CMbSSWfyKn4UzoAJfdyobAn2JoVm95souIc=";
  };

  repo = "bbv";
  owner = "mit-plv";
  domain = "github.com";

  propagatedBuildInputs = [
    stdlib
    coq # For compatibility commands
  ];

  opam-name = "coq-bbv";
}
