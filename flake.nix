{
  description = "Collection of my templates";

  outputs =
    { self }:
    {
      templates = {
        c = {
          path = ./c;
        };

        empty = {
          path = ./empty;
        };

        haskell = {
          path = ./haskell;
          welcomeText = ''
            # Haskell development shell

            run `stack new PROJECT_NAME --bare ./stack_template/template.hsfiles` to initialize, then you can delete the `stack_template` folder

            run `gen-ghie > hie.yaml` to generate the hie
          '';
        };

        jupyter = {
          path = ./jupyter;
        };

        latex = {
          path = ./latex;
        };

        python = {
          path = ./python;
        };

        rdevel = {
          path = ./rdevel;
        };

        scala = {
          path = ./scala;
        };

        scala-school = {
          path = ./scala-school;
        };

        zig = {
          path = ./zig;
          welcomeText = ''
            # Zig development shell

            run `zig init` to initialize
          '';
        };
      };
    };
}
