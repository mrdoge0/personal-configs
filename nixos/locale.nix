##
## NIXOS CONFIG FOR LOCALIZATION AND TIMEZONES
##
{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Language time
  i18n = {
    # yes i am turkish
    defaultLocale = "tr_TR.UTF-8";

    # just in case for any potential locale bug on an app
    extraLocaleSettings = {
      LC_ADDRESS        = "tr_TR.UTF-8";
      LC_IDENTIFICATION = "tr_TR.UTF-8";
      LC_MEASUREMENT    = "tr_TR.UTF-8";
      LC_MONETARY       = "tr_TR.UTF-8";
      LC_NAME           = "tr_TR.UTF-8";
      LC_NUMERIC        = "tr_TR.UTF-8";
      LC_PAPER          = "tr_TR.UTF-8";
      LC_TELEPHONE      = "tr_TR.UTF-8";
      LC_TIME           = "tr_TR.UTF-8";
    };
  };

  # Keymap
  services.xserver.xkb.layout = "tr";

  # Timezone
  time.timeZone = "Europe/Istanbul";

  # English as an extra locale, and config to use XKB keymap in TTY is expected from main.nix
}
