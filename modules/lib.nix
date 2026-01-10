{ inputs, ... }:
let
  library = import ../lib inputs.nixpkgs.lib inputs.flake-parts.lib;

  module = {
    flake.lib = {
      inherit (library) mkFlake modulesIn moduleWithOptionalPartitionedAttr;
    };
  };
in
{
  imports = [ module ];
  flake.modules.flake.flake = module;
}
