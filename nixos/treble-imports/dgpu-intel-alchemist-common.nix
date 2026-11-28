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
  imports = [ ( toString ./. + "/fwupd-common.nix" ) ];
  
  # Enforce "xe" driver for my Arc A750 LE
  # Performance sucks and I get GPU hangs in some games w/ "i915" (which is Alchemist's default)
  boot.kernelParams = [ "i915.force_probe=!56a1" "xe.force_probe=56a1" ];
  
  # Alchemist-related Mesa snippet
  # ("hardware.graphics.enable=true" and "hardware.graphics.enable32Bit=true" are (and expected to be) set in main as it's common accross all dGPU/iGPU brands and generations)
  hardware.graphics.extraPackages = with pkgs; [
    intel-compute-runtime
    intel-media-driver
    vpl-gpu-rt
  ];

  # Ollama: Use the ollama-vulkan package because it is the best performing with Arc
  # (god I wish Intel had it's own CUDA/ROCm alternative)
  services.ollama.package = pkgs.ollama-vulkan;

  # Environment variable to use Intel VAAPI
  environment.sessionVariables = rec {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
