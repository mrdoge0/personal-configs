##
## HW-SPECIFIC NIXOS CONFIG PART:
## INTEL ALCHEMIST (ARC A-SERIES) dGPUS
##
{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Import FWUPD
  imports = [ "fwupd-common.nix" ];
  
  # Enforce "xe" driver for my Arc A750 LE
  # Performance sucks and I get GPU hangs in some games w/ "i915" (which is Alchemist's default)
  boot.kernelParams = [ "i915.force_probe=!56a1" "xe.force_probe=56a1" ];
  
  # Alchemist-related Mesa snippet
  hardware.graphics.extraPackages = with pkgs; [
    intel-compute-runtime
    intel-media-driver
    vpl-gpu-rt
  ];

  # Environment variable to use Intel VAAPI
  environment.sessionVariables = rec {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
