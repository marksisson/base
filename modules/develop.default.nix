{ moduleWithOptionalPartitionedAttr, ... }:
let

  module =
    moduleWithOptionalPartitionedAttr "devShells" {
      perSystem = { pkgs, ... }: {
        develop.default = {
          packages = [ pkgs.just ];
        };
      };
    };

in
{
  imports = [ module ];
  flake.modules.flake.default = module;
}
