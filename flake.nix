{
  description = "A flake to be able to tinker with Rocq-Sail";

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
      in
      {
        default = rocqPackages.callPackage ./nix/dev-shell.nix {};

        proof-general = rocqPackages.callPackage ./nix/dev-shell.nix { withEmacs = true; };
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

        rocq-sail-stdpp = pkgs.rocqPackages.callPackage ./package.nix { with-stpp = true; };

        default = rocq-sail;
      }
    );

  };
}
