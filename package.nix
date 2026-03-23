{
  lib,
  rocqPackages,
  stdlib,
  stdpp,
  ocamlPackages,
}:

rocqPackages.mkRocqDerivation {
  pname = "coq-sail";
  version = "0.20.1";
  release = {
    "0.20.1".hash = "sha256-3+SeVKDuK+xnNt6mub6TdYG7H/Y0vD+b2/90toM0jAY=";
  };
  owner = "rems-project";
  domain = "github.com";

  propagatedBuildInputs = [
    # Rocq libs
    stdlib
    stdpp
    (rocqPackages.callPackage ./nix/coq-bbv.nix {})
    # Ocaml libs
    ocamlPackages.odoc
  ];
  # useDune = true; # Replaced with a Makefile currently
  # opam-name = "coq-sail";
  # opam-name = "coq-sail-stdpp"; # TODO ?

  patches = [
    ./patches/rocq-compat.patch
  ];

  meta = {
    description = "The Sail ISA specification language - Rocq support library.";
    license = lib.licenses.bsd2;
  };
}

