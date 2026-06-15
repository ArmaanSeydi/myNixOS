{ self, inputs, ... }: {
  
  flake.nixosModules.laptopConfiguration = { config, pkgs, ... }: {
    imports = [ 
      self.nixosModules.laptopHardware
      self.nixosModules.common
      ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelParams = [ "usbcore.quirks=325d:6410:k" "quiet" "loglevel=3" ];
    boot.initrd.verbose = false;
    boot.consoleLogLevel = 0;
    boot.plymouth.enable = true;
    
    #services.resolved.enable = true;
    #networking.nameservers = [
    #  "178.22.122.101"
    #  "185.52.200.1"
    #];

    zramSwap.enable = true;

    networking.hostName = "laptop";

    networking.networkmanager.enable = true;

    time.timeZone = "Asia/Tehran";

    i18n.defaultLocale = "en_US.UTF-8";

    services.xserver.enable = true;
    services.xserver.xkb = {
      layout = "us,ir";
      variant = ",";
      options = "grp:alt_shift_toggle";
    };

    services.logind.settings.Login.HandleLidSwitch = "lock";

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "where_is_my_sddm_theme";
      extraPackages = [ pkgs.qt6Packages.qt5compat ];
    };
    services.displayManager.defaultSession = "niri";

    services.printing.enable = true;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

    virtualisation.docker.enable = true;

    programs.xwayland.enable = true;
    programs.zsh.enable = true;

    users.users.armaan = {
      isNormalUser = true;
      description = "Armaan Seydi";
      shell = pkgs.zsh;
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" "video" ];
      packages = with pkgs; [
        firefox
        steam
        vlc
        obsidian
        nautilus
        gnome-boxes

        # Image viewer
        imv

        # Music player
        amberol

        # PDF viewer
        evince

        # Archive manager
        file-roller

        # Office suite
        libreoffice

        # Torrent client
        qbittorrent

        # Email client
        thunderbird

        # Calculator
        gnome-calculator
      ];
    };


    environment.systemPackages = with pkgs; [
      claude-code
      (where-is-my-sddm-theme.override {
        themeConfig.General = {
          backgroundFill = "#${config.lib.stylix.colors.base00}";
          basicTextColor = "#${config.lib.stylix.colors.base06}";
          passwordCursorColor = "#${config.lib.stylix.colors.base0C}";
          passwordTextColor = "#${config.lib.stylix.colors.base06}";
          font = "JetBrainsMono Nerd Font";
          passwordFontSize = 48;
          passwordInputWidth = "0.35";
          passwordCharacter = "❄";
          cursorBlinkAnimation = true;
        };
      })
    ];
    
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    nix.settings.auto-optimise-store = true;
    boot.loader.systemd-boot.configurationLimit = 5;

    services.openssh.enable = true;
    
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nix.settings.extra-substituters = [ "https://noctalia.cachix.org" ];
    nix.settings.extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];

    services.gvfs.enable = true;
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
    hardware.bluetooth.enable = true;

    system.stateVersion = "26.05"; 

  };
}
