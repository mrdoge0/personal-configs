##
## HW-SPECIFIC NIXOS CONFIG PART:
## IOMMU COMMON
##
{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Set IOMMU to passthrough mode
  boot.kernelParams = [ "iommu=pt" ];
}
