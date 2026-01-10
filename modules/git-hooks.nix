{ lib, ... }:
let
  module =
    {
      partitions.development.module = { inputs, options, ... }: {

        imports = [ inputs.git-hooks.flakeModule ];

        perSystem = { config, ... }: {
          pre-commit.settings.hooks = {
            treefmt.enable = true;
            treefmt.package = config.treefmt.build.wrapper;
          };
        } // lib.optionalAttrs (options ? develop) {
          develop.default.packages = with config.pre-commit; settings.enabledPackages;

          develop.default.shellHook = ''
            ${with config.pre-commit; shellHook}
          '';
        };

      };
    };
in
{
  imports = [ module ];
  flake.modules.flake.default = module;
}
