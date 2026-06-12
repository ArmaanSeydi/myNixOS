{ self, inputs, ... }: {

  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux"; 
    modules = [
      self.nixosModules.laptopConfiguration
      self.nixosModules.homeManager
      self.nixosModules.stylix
      self.nixosModules.fonts
      self.nixosModules.hyprland
      self.nixosModules.niri
#      self.nixosModules.secureBoot
    ];
  };

}
