{
  description = "literate programming filters for Agda and Haskell";

  inputs.nixpkgs.url = github:NixOS/nixpkgs;
  inputs.flake-utils.url = github:numtide/flake-utils;

  outputs = {self, nixpkgs, flake-utils}:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {inherit system;};
        filters = pkgs.haskellPackages.callCabal2nix "pandoc-literate-filters" ./. {};
      in {
        packages = {
          inherit filters;
          default = filters;
        };
        devShells.default = pkgs.haskellPackages.shellFor {
          packages = p: [filters];
          buildInputs = with pkgs.haskellPackages; [
            cabal-install
            cabal2nix
            haskell-language-server
            pandoc
          ];
        };
      });
}
