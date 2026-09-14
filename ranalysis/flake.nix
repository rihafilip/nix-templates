{
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
        {
          devShells.default = pkgs.mkShell ({
            name = "R analysis";

            packages =
              with pkgs;
              [
                R
                pandoc
              ]
              ++ (with rPackages; [
                languageserver
                httpgd

                # Rmarkdown
                knitr
                rmarkdown

                # Analysis dependencies
                ggplot2
                patchwork
                scales
                forcats
                DT
                boot
                tidyverse
                Hmisc

                (buildRPackage rec {
                  pname = "texvars";
                  version = "0.1.0";

                  src = fetchFromGitHub {
                    owner = "fikovnik";
                    repo = pname;
                    rev = "main";
                    hash = "sha256-GysgnSvfJxF11ewA9JzhkRnO4EerdJXQrV46RbKS4H8=";
                  };

                  nativeBuildInputs = [
                    dplyr
                    DT
                    tibble
                  ];
                })
              ]);
          });
        };
    };
}
