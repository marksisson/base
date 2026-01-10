{
  description = "A collection of flake modules for various purposes.";

  outputs = inputs: with import ./lib inputs.nixpkgs.lib inputs.flake-parts.lib;
    mkFlake { inherit inputs; } { imports = modulesIn ./modules; };

  inputs = {
    flake-parts.url = "https://flakehub.com/f/hercules-ci/flake-parts/0";
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0";
    systems.url = "github:nix-systems/default";
  };
}
