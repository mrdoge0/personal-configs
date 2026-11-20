##
## HW NIXOS CONFIG PART
## FWUPD
##
{
  config,
  lib,
  pkgs,
  ...
}:

{
  # do black magic
  services.fwupd.enable = true;
}
