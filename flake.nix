{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs }:
  let
    lib = nixpkgs.lib;

    forAllSystems = lib.genAttrs lib.systems.flakeExposed;
  in
  {
    devShells = forAllSystems (
      system:
      let
        pkgs = import nixpkgs { inherit system; };

        rocqPackages = pkgs.rocqPackages;
        # rocq-env = pkgs.coqPackages.coq.withPackages (
        # # rocq-env = pkgs.rocqPackages.rocq-core.withPackages (
        # # rocq-env = pkgs.rocqPackages.coq.withPackages (
        #   ps: with ps; [
        #     stdlib
        #     stdpp

        #     coq.ocamlPackages.ocaml
        #   ]
        # );
      in
      {
        default = pkgs.mkShell {
          packages = [
            rocqPackages.rocq-core
            rocqPackages.stdlib
            rocqPackages.stdpp
            (rocqPackages.callPackage ./nix/coq-bbv.nix {})
            pkgs.dune
          ];
        };
      }
    );

    packages = forAllSystems (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      rec {
        rocq-sail = pkgs.rocqPackages.callPackage ./package.nix {};
        # rocq-sail = pkgs.callPackage ./package.nix {};

        default = rocq-sail;
      }
    );

  };
}
