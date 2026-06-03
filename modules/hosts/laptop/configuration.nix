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

    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

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

    programs.zsh.enable = true;

    users.users.armaan = {
      isNormalUser = true;
      description = "Armaan Seydi";
      shell = pkgs.zsh;
      extraGroups = [ "networkmanager" "wheel" "libvirtd"];
      packages = with pkgs; [
        firefox
        steam
        vlc
        gnomeExtensions.caffeine
      ];
    };


    environment.systemPackages = with pkgs; [
      gnome-boxes
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

    system.stateVersion = "26.05"; 

  };
}
