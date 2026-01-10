nixpkgs-lib: flake-parts-lib:
let
  mkFlake = args: module:
    let
      specialArgs = { inherit moduleWithOptionalPartitionedAttr; };
    in
    flake-parts-lib.mkFlake (args // { inherit specialArgs; }) module;

  modulesIn = directory: with nixpkgs-lib; filter (n: strings.hasSuffix ".nix" n) (filesystem.listFilesRecursive directory);

  moduleWithOptionalPartitionedAttr =
    partitionedAttr: moduleConfig:

    { config, lib, ... }:
    let
      isPartitioned = config.partitionedAttrs ? ${partitionedAttr};
      partition = config.partitionedAttrs.${partitionedAttr} or null;
    in
    {
      config = lib.mkMerge [
        (lib.mkIf isPartitioned {
          partitions.${partition}.module = moduleConfig;
        })

        (lib.mkIf (!isPartitioned) moduleConfig)
      ];
    };
in
{
  inherit mkFlake modulesIn moduleWithOptionalPartitionedAttr;
}
