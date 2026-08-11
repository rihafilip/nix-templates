{
  description = "Haskell development shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-parts,
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
      ];

      perSystem =
        { pkgs, ... }:
        let
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
            packages = myDevTools;
          };
        };
    };
}
