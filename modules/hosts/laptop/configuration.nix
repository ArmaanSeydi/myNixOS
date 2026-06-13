{ self, inputs, ... }: {
  
  flake.nixosModules.laptopConfiguration = { config, pkgs, ... }: {
    imports = [ 
      self.nixosModules.laptopHardware
      self.nixosModules.common
      ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    
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
      layout = "us";
      variant = "";
    };

    services.displayManager.gdm.enable = true;

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

    programs.zsh.enable = true;

    users.users.armaan = {
      isNormalUser = true;
      description = "Armaan Seydi";
      shell = pkgs.zsh;
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" ];
      packages = with pkgs; [
        firefox
        steam
        vlc
        obsidian
        nautilus
      ];
    };


    environment.systemPackages = with pkgs; [
      claude-code
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

    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
    hardware.bluetooth.enable = true;

    system.stateVersion = "26.05"; 

  };
}
