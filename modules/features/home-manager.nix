{ self, inputs, ... }: {

  flake.nixosModules.homeManager = { config, ... }: {
    imports = [ 
      inputs.home-manager.nixosModules.home-manager
    ];
    
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    nixpkgs.config.allowUnfree = true;
    home-manager.sharedModules = [
      inputs.nixvim.homeModules.nixvim
      self.homeModules.nixvim
      self.homeModules.tmux
      self.homeModules.kitty
      self.homeModules.zsh
      self.homeModules.godot
      self.homeModules.libresprite
    ];

    home-manager.users.armaan = { ... }: {
      stylix.enableReleaseChecks = false;
      programs.home-manager.enable = true;
      programs.nixvim.nixpkgs.source = inputs.nixpkgs;
      programs.git = {
        enable = true;
        settings.user.name = "armaan seydi";
        settings.user.email = "armaanseydi@gmail.com";
      };

      home.username = "armaan";
      home.homeDirectory = "/home/armaan";
      home.stateVersion = "26.05";
    };
  };

}
