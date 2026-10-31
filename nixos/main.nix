##
## MAIN NIXOS CONFIG
##
{
  config,
  lib,
  pkgs,
  ...
}:

let
  # Fetch nix-flatpak
  nix-flatpak = builtins.fetchGit { url = "https://github.com/gmodena/nix-flatpak"; };

  # Fetch Home Manager
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";

  # Fetch NixOS 23.05
  pkgs2305 =
    import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-23.05.tar.gz")
      { };

  # Fetch the MangoBar HM Flake
  mangobar = builtins.getFlake "github:mangowm/mangobar/main";
in
{
  # Imports
  imports = [
    # External: nix-flatpak
    "${nix-flatpak}/modules/nixos.nix"

    # External: Home Manager
    (import "${home-manager}/nixos")
  ];

  # Core Nix PM config
  system.stateVersion = "26.05";
  nixpkgs.config.allowUnfree = true;
  nix = {
    gc.automatic = true;
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  # Kernel parameters (common)
  boot.kernelParams = [
    "ignore_loglevel"
    "earlyprintk"
    "threadirqs"
  ];

  # NetworkManager
  networking.networkmanager = {
    enable = true;
  };

  # Timezone
  time.timeZone = "Europe/Istanbul";

  # Language time
  i18n = {
    defaultLocale = "tr_TR.UTF-8";
    extraLocales = [
      "en_US.UTF-8/UTF-8"
    ];
  };
  console.useXkbConfig = true;

  # Services
  services = {
    # X11/Wayland
    xserver = {
      enable = true;
      xkb.layout = "tr";
    };

    # GVFS and udisks2
    gvfs.enable = true;
    udisks2.enable = true;

    # CUPS
    printing.enable = true;

    # OpenSSH
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        AllowUsers = [ "Teto" ];
      };
    };

    # SDDM
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      extraPackages = [ pkgs.catppuccin-sddm ];
      theme = "catppuccin-mocha-mauve";
    };

    # Pipewire
    pipewire = {
      enable = true;
      wireplumber.enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa.enable = true;
      jack.enable = true;
    };

    # F(l)atpak
    flatpak = {
      enable = true;

      # Remotes (nix-flatpak)
      remotes = lib.mkOptionDefault [
        # Flathub Beta
        {
          name = "flathub-beta";
          location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
        }

        # Mixtapes
        {
          name = "mixtapes";
          location = "https://m-obeid.github.io/Mixtapes/mixtapes.flatpakrepo";
        }
      ];

      # Explicitly installed packages (nix-flatpak)
      packages = [
        # Flatseal
        {
          appId = "com.github.tchx84.Flatseal";
          origin = "flathub";
        }

        # Mixtapes
        {
          appId = "com.pocoguy.Muse";
          origin = "mixtapes";
        }

        # FDM
        {
          appId = "org.freedownloadmanager.Manager";
          origin = "flathub";
        }

        # Gauge
        {
          appId = "io.github.josephmawa.Gauge";
          origin = "flathub";
        }
      ];
    };

    # GNOME stuff
    gnome = {
      # GNOME Keyring
      gnome-keyring.enable = true;

      # Sushi image viewer library
      sushi.enable = true;
    };

    # Ananicy-CPP
    ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-rules-cachyos;
    };

    # Syncthing
    syncthing = {
      enable = true;
      user = "Teto";
      dataDir = "/home/Teto/Syncthing";
    };
  };

  # Programs
  programs = {
    # SUID wrappers
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # ZSH
    zsh = {
      enable = true;
      ohMyZsh.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestions.enable = true;
    };

    # Java
    java = {
      enable = true;
      package = pkgs.temurin-bin-27;
    };

    # Neovim
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      withPython3 = true;
    };

    # MangoWM
    mango.enable = true;

    # Nautilus open any terminal
    nautilus-open-any-terminal = {
      enable = true;
      terminal = "kitty";
    };

    # Chromium
    chromium = {
      # I feel like vanilla Chromium today
      enable = true;

      # Let's declare the essential settings
      extraOpts = {
        "BrowserSignin" = "0";
        "SyncDisabled" = true;
        "PasswordManagerEnabled" = false;
        "SpellcheckEnabled" = true;
        "SpellcheckLanguage" = [
          "tr"
          "en-US"
        ];
        "WebAppInstallForceList" = [
          {
            "custom_name" = "Proton Pass";
            "create_desktop_shortcut" = true;
            "default_launch_container" = "window";
            "url" = "https://pass.proton.me";
          }
        ];
      };

      # Sure, let's declare my essential extensions
      extensions = [
        "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBO Lite (can't live at all w/o normal uBO on Firefox-based and uBO Lite on Chromium-based :D)
        "gebbhagfogifgggkldgodflihgfeippi" # Return YT Dislike
        "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock for YT
        "iplffkdpngmdjhlpjmppncnlhomiipha" # Unpaywall
        "ghmbeldphafepmbegfdlkpapadhbakde" # Proton Pass
        "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
        "cpbiigflocpkmbclhjndgfalelmegokd" # Random YT no dubbing extension
        "fgmjlmbojbkmdpofahffgcpkhkngfpef" # Startpage
      ];
    };

    # Git
    git = {
      enable = true;
      lfs.enable = true;
    };

    # VS Code
    vscode = {
      enable = true;

      # it's a nice idea to declare all your essential vscode extensions beforehand
      extensions = with pkgs.vscode-extensions; [
        ms-python.python
        zainchen.json
        ms-pyright.pyright
        redhat.java
        redhat.vscode-xml
        redhat.vscode-yaml
        ms-dotnettools.csharp
        github.github-vscode-theme
        ms-vscode.cpptools
      ];
    };

    # Wireshark
    wireshark = {
      enable = true;
      usbmon.enable = true;
      package = pkgs.wireshark;
    };

    # KDE Connect
    kdeconnect.enable = true;

    # GNOME Disks
    gnome-disks.enable = true;

    # LocalSend
    localsend.enable = true;

    # ONLYOFFICE Desktop Editors
    onlyoffice.enable = true;

    # Nix LD
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        # Standards
        stdenv.cc.cc.lib
        gtk3
        pango
        atk
        cairo
        gdk-pixbuf
        glib
        gobject-introspection
        mpv
        libepoxy
        fontconfig
        gnutls
        libxcb
        libxcb-util
        libxcb-wm
        libxcb-image
        libxcb-render-util
        libxcb-errors
        libxcb-cursor

        # Codecs are fun
        sndio
        libcdio-paranoia
        libvdpau
        libcaca
        lame
        twolame
        libopus
        speex
        pkgs2305.libtheora
        libvorbis
        wavpack
        xvidcore
        snappy
        openjpeg
        openjph
        zvbi
        libuchardet
        game-music-emu
        libopenmpt
        chromaprint
        libbs2b
        lilv
        soxr
        libdvdnav_4_2_1
        libraw1394
        libavc1394
        libiec61883
        openal
        libass
        zeromq
        vid-stab
        libssh
        vulkan-loader
        vulkan-headers
        vulkan-validation-layers
        libjpeg_turbo
        gsm
        libpulseaudio

        # In order to make Fernus ZKitapX run
        libarchive
        alsa-lib
        libglvnd
        egl-wayland
        egl-gbm
        egl-x11
        eglexternalplatform
        libgbm
        libva
        libxscrnsaver
        pkgs2305.rubberband
        pkgs2305.libbluray
        libdrm
        libxv
        samba
        lua5_2
        lcms2
        libxxf86vm
        libxxf86dga
        libxxf86misc
        libwebp
        librsvg
        shine
        libgcrypt
        flite
        numactl
        libjack2
        libusb1
      ];
    };
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    adwaita-fonts
    corefonts
  ];

  # Polkit
  security.polkit = {
    enable = true;
    enablePkexecWrapper = true;
  };

  # Qt5/6 stuff
  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };

  # XDG Portal
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-generic
    ];
  };

  # Systemd extra config
  systemd = {
    # Actually use the Polkit agent
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # Home Manager configuration
  home-manager = {
    # Config for my user
    users.Teto = {
      # HM Imports
      imports = [
        # Flake: MangoBar
        mangobar.homeManagerModules.default
      ];

      # Core HM config
      home = {
        stateVersion = "26.05";
        homeDirectory = "/home/Teto";
        username = "Teto";
      };

      # Services
      services = {
        # MangoBar
        mangobar = {
          enable = true;

          # Settings
          settings = {
            sys-interval = 1;
            modules-left = [
              "workspaces"
              "layout"
              "window"
            ];
            modules-right = [
              "tray"
              "hideclients"
              "network"
              "pulseaudio"
              "cpu"
              "memory"
              "clock#time"
            ];
          };
        };
      };
    };
  };

  # Users and groups
  users = {
    # Teto (my main user)
    users.Teto = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [
        "Teto"
        "AllRealUsers"
        "wheel"
        "networkmanager"
        "wireshark"
        "kvm"
        "libvirtd"
        "input"
        "adbusers"
      ];
      home = "/home/Teto";
      shell = pkgs.zsh;
    };

    # Groups
    groups = {
      # All real users
      AllRealUsers.gid = 9000;

      # Teto (for compatibility of the HDD's permissions between conventional distros and NixOS)
      Teto.gid = 1000;
    };
  };

  # Environment
  environment = {
    # Extra session vars
    sessionVariables = rec {
      CPUX_ARGS = "-d";
    };

    # Misc system packages
    systemPackages = with pkgs; [
      # Core GUI/XDG plugins
      glib
      polkit_gnome
      xdg-user-dirs

      # Python
      python3

      # Terminal programs
      binutils
      fastfetch
      lsd
      nixfmt
      usbutils
      vulkan-tools

      # Tiling WM Plugins and Kitty terminal
      grim
      kitty
      pavucontrol
      rofi
      swaybg
      swaynotificationcenter
      wlogout

      # GNOME stuff
      baobab
      gnome-calculator
      gnome-characters
      gnome-font-viewer
      lorem
      loupe
      nautilus

      # Chromium (for some reason programs.chromium.enable will not install Chromium itself)
      chromium

      # Obsidian
      obsidian

      # Qt customization
      kdePackages.qt6ct
      kdePackages.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum

      # Productive programs
      gimp-with-plugins
      krita

      # Gaming time (but not that intensive)
      supertuxkart

      # Wine
      wineWow64Packages.stagingFull

      # Data recovery (cus i still have a dead hdd to rescue data from)
      testdisk-qt

      # VPN
      proton-vpn

      # Development
      android-studio
      android-tools
      edl
      github-cli
      heimdall

      # Themes
      adw-gtk3
      bibata-cursors
      catppuccin-sddm
      morewaita-icon-theme

      # Archiving tools
      unrar
      unzip
      rar
      zip

      # Media player
      vlc

      # System info tools
      cpu-x
      furmark
      kdiskmark
      mission-center
      waycheck
    ];
  };
}
