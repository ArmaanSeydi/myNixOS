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

    programs.regreet.enable = true;

    # Replace cage with sway so we can enable tap-to-click via libinput config.
    # programs.regreet uses lib.mkDefault for the session command, so this wins.
    services.greetd.settings.default_session.command =
      "${pkgs.dbus}/bin/dbus-run-session -- ${pkgs.sway}/bin/sway --config /etc/greetd/sway-config";

    environment.etc."greetd/sway-config".text = ''
      input type:touchpad {
        tap enabled
      }
      exec "${pkgs.regreet}/bin/regreet; ${pkgs.sway}/bin/swaymsg exit"
    '';

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

    system.stateVersion = "26.05"; 

  };
}
