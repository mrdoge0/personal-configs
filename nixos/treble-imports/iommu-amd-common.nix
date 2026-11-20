##
## HW-SPECIFIC NIXOS CONFIG PART:
## IOMMU FOR AMD
##
{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Import common IOMMU
  imports = [ "./iommu-common.nix" ];

  # AMD IOMMU on
  boot.kernelParams = [ "amd_iommu=on" ];
}
