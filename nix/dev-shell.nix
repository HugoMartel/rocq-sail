{
  mkShell,

  # Rocq
  rocqPackages,

  # Emacs
  emacs-pgtk,
  emacsPackagesFor,
  runCommand,
  makeWrapper,
  withEmacs ? false,
}:
let
  rocqEnv = with rocqPackages; [
    rocq-core
    stdlib
    stdpp
    (callPackage ./coq-bbv.nix {})
  ];
in
if withEmacs
then
  let
    emacsConfiguration = runCommand "emacs-config" { } ''
      mkdir -p $out
      ln -s ${./emacs-config.el} $out/init.el
    '';

    emacs = (emacsPackagesFor emacs-pgtk).emacsWithPackages (
      epkgs: with epkgs; [
        # Vim key bindings
        evil
        # meow # TODO: write config meself?
        # Math symbols
        math-symbol-lists
        # Rocq plugin
        proof-general
      ]
    );
    wrappedEmacs = runCommand "emacs" { nativeBuildInputs = [ makeWrapper ]; } ''
    makeWrapper ${emacs}/bin/emacs $out/bin/emacs --add-flags '--init-directory ${emacsConfiguration}'
    '';
  in
  mkShell {
    packages = [
      rocqEnv
      wrappedEmacs
    ];

  }
else
  mkShell {
    packages = [
      rocqEnv
    ];
  }

  
