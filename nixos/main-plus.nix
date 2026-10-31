##
## MORE NIXOS CONFIG FOR HIGHER-END SYSTEMS
##
{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Guest rule for SSH
  services.openssh.settings.DenyUsers = [ "Guest" ];

  # Programs
  programs = {
    # Steam
    steam = {
      enable = true;
      extest.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
      protontricks.enable = true;
    };

    # virt-manager
    virt-manager.enable = true;
  };

  # Virtualization and containerization
  virtualisation = {
    # Libvirt
    libvirtd = {
      enable = true;
      dbus.enable = true;
      qemu = {
        swtpm.enable = true;
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };

    # Docker
    docker.enable = true;
  };

  # Guest (the arbitrary user account w/ the minimum privileges)
  users.users.Guest = {
    isNormalUser = true;
    uid = 1001;
    extraGroups = [ "AllRealUsers" ];
    home = "/home/Guest";
    shell = pkgs.zsh;
    password = "1234";
  };

  # More packages
  environment.systemPackages = with pkgs; [
    # MangoHud
    (mangohud.overrideAttrs (old: {
      patches = (old.patches or [ ]) ++ [
        (pkgs.fetchpatch {
          url = "https://raw.githubusercontent.com/mrdoge0/personal-configs/refs/heads/main/gentoo/patches/games-util/mangohud/mangohud-0.8.4-ram_text-vram_text.patch";
          hash = "sha256-4fVzyc+VaWH3NvistZPP5UsetSth2RbIn2pkr25QuA0=";
        })
      ];
    }))

    # Gaming time
    heroic

    # Containers
    boxbuddy
    distrobox
  ];
}
