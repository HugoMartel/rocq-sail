{
  lib,
  rocqPackages,
  stdlib,
  stdpp,
  ocamlPackages,
  with-stdpp ? false
}:

rocqPackages.mkRocqDerivation {
  pname = "rocq-sail";
  version = "0.20.1";

  src = ./.;

  # release = {
  #   # Upstream release
  #   "0.20.1".hash = "sha256-3+SeVKDuK+xnNt6mub6TdYG7H/Y0vD+b2/90toM0jAY=";
  # };
  # owner = "HugoMartel"; # Fork
  # owner = "rems-project";
  # domain = "github.com";

  propagatedBuildInputs = [
    # Rocq libs
    stdlib
    (rocqPackages.callPackage ./nix/coq-bbv.nix {})
    # Ocaml libs
    ocamlPackages.odoc
  ] ++
  (if with-stdpp then [ stdpp ] else []);
  opam-name = if with-stdpp then "rocq-sail-stdpp" else "rocq-sail";

  meta = {
    description = "The Sail ISA specification language - Rocq support library.";
    license = lib.licenses.bsd2;
  };
}

