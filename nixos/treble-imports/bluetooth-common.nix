##
## HW-SPECIFIC NIXOS CONFIG PART:
## BLUETOOTH
##
{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Enable BlueZ
  hardware.bluetooth = {
    enable = true;
    settings.General = {
      Experimental = true;
      Enable = "Source,Sink,Media,Socket";
    };
  };

  # BT-related services snippet
  services = {
    # BlueMan (potentially the worst BT client, but..)
    blueman.enable = true;

    # Extra WirePlumber config to enforce A2DP
    pipewire.wireplumber.extraConfig."60-bluez-a2dp-only" = {
      "monitor.bluez.properties"."bluez5.roles" = [ "a2dp_sink" "a2dp_source" ];
      "wireplumber.settings"."bluetooth.autoswitch-to-headset-profile" = false;
    };
  };
}
