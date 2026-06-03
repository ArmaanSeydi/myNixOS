{ ... }: {
  flake.homeModules.libresprite = { pkgs, ... }: {
    home.packages = [ pkgs.libresprite ];
  };
}
