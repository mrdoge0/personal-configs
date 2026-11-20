##
## HW-SPECIFIC NIXOS CONFIG PART:
## systemd-boot BOOTLOADER FOR UEFI SYSTEMS
##
{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Use the systemd-boot bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 0;
    systemd-boot = {
      enable = true;
      consoleMode = "max";
      editor = false;
      memtest86.enable = true;
    };
  };
}
