##
## HW-SPECIFIC NIXOS CONFIG PART
## BTRFS
##
{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Auto scrub on BTRFS drives
  # Please set services.btrfs.autoScrub.fileSystems using the actual Treble config
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };
}
