{
  description = "Python Jupyter notebook development shell";

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
          devShells.default = pkgs.mkShell {
            name = "Python Jupyter";
            packages = with pkgs; [
              (python3.withPackages (
                ps: with ps; [
                  jupyter
                  scipy
                  pandas
                  matplotlib
                ]
              ))
            ];
          };
        };
    };
}
