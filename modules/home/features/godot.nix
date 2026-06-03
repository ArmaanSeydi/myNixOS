{ ... }: {
  flake.homeModules.godot = { pkgs, ... }: {
    home.packages = [ pkgs.godot_4 ];
  };
}
