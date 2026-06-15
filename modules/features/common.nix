
{ self, ... }: {

  flake.nixosModules.common = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [

      # Core CLI
      wget
      curl
      vim

      unzip
      zip
      p7zip

      file
      which
      tree
      killall

      # Better CLI Tools
      eza
      bat
      fd
      ripgrep
      fzf
      zoxide

      btop
      htop
      dust
      duf
      procs

      # Networking
      dig
      inetutils
      nmap
      traceroute
      tcpdump

      # Dev Tools
      gcc
      gnumake
      cmake

      python3
      nodejs

      cargo
      rustc

      jq
      yq-go

      # Monitoring
      fastfetch
      lm_sensors
      pciutils
      usbutils

      # Fun Stuff
      cmatrix
      cava
      pipes
      asciiquarium

      # Media
      ffmpeg
      imagemagick
      yt-dlp
      audacity
      kdePackages.kdenlive

      # Wayland QoL
      wl-clipboard
      brightnessctl
      playerctl
      libnotify
    ];
  };

}

