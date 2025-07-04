{
  description = "Haskell development shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        hPkgs = pkgs.haskell.packages."ghc963";

        stack-wrapped = pkgs.symlinkJoin {
          name = "stack";
          paths = [ pkgs.stack ];
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            wrapProgram $out/bin/stack \
              --add-flags "\
                --no-nix \
                --system-ghc \
                --no-install-ghc \
              "
          '';
        };

        myDevTools = with hPkgs; [
          ghc
          stack-wrapped
          ormolu # Haskell formatter
          hlint # Haskell codestyle checker
          haskell-language-server # LSP
          pkgs.haskellPackages.implicit-hie
        ];
      in
      {
        devShells.default = pkgs.mkShell {
          name = "Haskell";
          buildInputs = myDevTools;
        };
      }
    );
}
