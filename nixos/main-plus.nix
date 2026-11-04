##
## MORE NIXOS CONFIG FOR HIGHER-END SYSTEMS
##
{
  config,
  lib,
  pkgs,
  ...
}:

let
  # Hyper Simple Flakes Collection
  hypersimple-flakes-collection = builtins.getFlake "github:mrdoge0/hypersimple-flakes-collection/main";
in
{
  # Services
  services = {
    # Guest rule for SSH
    openssh.settings.DenyUsers = [ "Guest" ];

    # LACT
    lact.enable = true;
  };

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

    # OBS Studio
    obs-studio = {
      enable = true;
    };
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
    extraGroups = [ "AllRealUsers" "video" "render" ];
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

    # Slop Upscaler
    upscayl

    # Legacy Launcher (my (or Mistral's) own vibecoded flake since nixpkgs will never publish pirated stuff :D)
    hypersimple-flakes-collection.packages.x86_64-linux.legacy-launcher
  ];
}
