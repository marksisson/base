{ config, inputs, lib, ... }:
let
  module =
    {
      imports = [ inputs.flake-parts.flakeModules.flakeModules ];
      flake.flakeModules = config.flake.modules.flake;
    };
in
{
  imports = [ module ];
  flake.modules.flake.flake = module;
}
