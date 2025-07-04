{
  description = "Collection of my templates";

  outputs =
    { self }:
    {
      templates = {
        c = {
          path = ./c;
          welcomeMessage = ''
            # C/C++ development shell

            The flake contains CMake and make, change if needed
          '';
        };

        haskell = {
          path = ./haskell;
          # TODO:
          welcomeMessage = ''
            # Haskell development shell

            run `stack new ` to initialize, then you can delete the "stack_template" folder

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
          welcomeMessage = ''
            # Python development environment

            pyrightconfig.json, pytest.ini and expect sources in the src folder

            Makefile expects the test it the test folder

            *Edit those if needed*
          '';
        };

        scala = {
          path = ./scala;
        };

        zig = {
          path = ./zig;
          welcomeMessage = ''
            # Zig development shell

            run `zig init` to initialize
          '';
        };
      };
    };
}
