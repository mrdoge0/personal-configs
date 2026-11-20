##
## HW-SPECIFIC NIXOS CONFIG PART:
## OPENRAZER
##
{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Enable OpenRazer
  hardware.openrazer.enable = true;

  # Add Teto to openrazer group
  users.users.Teto.extraGroups = [ "openrazer" ];

  # Razer packages
  environment.systemPackages = with pkgs; [
    # OpenRazer
    openrazer-daemon
    polychromatic
  ];
}
