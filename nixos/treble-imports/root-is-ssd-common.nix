##
## HW-SPECIFIC NIXOS CONFIG PART:
## ROOT IS SSD (SATA or NVMe)
##
{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Do the thing
  fileSystems."/".options = [ "discard" ];
}
