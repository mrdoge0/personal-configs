##
## MORE NIXOS CONFIG FOR HIGHER-END SYSTEMS
##
{
  config,
  lib,
  pkgs,
  ...
}:

# Fetch more extarnal stuff
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
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vaapi
      ];
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

    # Spice USB Redirection
    spiceUSBRedirection.enable = true;

    # Docker
    docker.enable = true;
  };

  # Users
  users.users = {
    # A few more packages for Teto
    Teto.packages = with pkgs; [
      # Gaming time (*little* more intensive)
      heroic

      # Containers
      boxbuddy
      distrobox

      # Slop Upscaler
      upscayl
    ];

    # Guest (the arbitrary user account w/ the minimum privileges)
    Guest = {
      # Main config
      isNormalUser = true;
      uid = 1001;
      extraGroups = [ "AllRealUsers" "video" "render" ];
      home = "/home/Guest";
      shell = pkgs.zsh;

      # OPSEC level: non-existent (/s)
      password = "1234";
    };
  };

  # More packages for everybody
  environment.systemPackages = with pkgs; [
    # MangoHud
    ( mangohud.overrideAttrs ( old: { patches = (old.patches or [ ]) ++ [ ( pkgs.fetchpatch {
      url = "https://raw.githubusercontent.com/mrdoge0/personal-configs/refs/heads/main/gentoo/patches/games-util/mangohud/mangohud-0.8.4-ram_text-vram_text.patch";
      hash = "sha256-4fVzyc+VaWH3NvistZPP5UsetSth2RbIn2pkr25QuA0=";
    } ) ]; } ) )

    # Legacy Launcher (my (or Mistral's) own vibecoded flake since nixpkgs will never publish pirated stuff :D)
    hypersimple-flakes-collection.packages.x86_64-linux.legacy-launcher
  ];
}
