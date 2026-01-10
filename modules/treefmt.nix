{ lib, ... }:
let
  module =
    {
      partitions.development.module = { inputs, options, ... }: {

        imports = [ inputs.treefmt.flakeModule ];

        perSystem = { config, pkgs, ... }: {
          treefmt = {
            projectRootFile = "flake.nix";
            package = pkgs.treefmt;
            programs = {
              nixpkgs-fmt.enable = true;
              shfmt.enable = true;
            };
          };
        } // lib.optionalAttrs (options ? develop) {
          develop.default.packages = with config.treefmt; builtins.attrValues build.programs;
        };

      };
    };
in
{
  imports = [ module ];
  flake.modules.flake.default = module;
}
