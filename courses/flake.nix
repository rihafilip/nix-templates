{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    course-pages.url = "github:rihafilip/course-pages-flake";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-parts,
      course-pages,
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
      ];

      perSystem =
        { pkgs, inputs', ... }:
        let
          node = pkgs.nodejs_24;
          cp = inputs'.course-pages.packages.course-pages;
        in
        {
          devShells.default = pkgs.mkShell {
            name = "Courses";
            packages = with pkgs; [
              gnumake
              node
              prettier
              cp
            ];

            shellHook = ''
              mkdir -p bin/
              ln -fs ${cp}/bin/course-pages bin/course-pages
            '';
          };
        };
    };
}
