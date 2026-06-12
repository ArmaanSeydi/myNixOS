{ ... }: {
  flake.nixosModules.niri = { ... }: {
    programs.niri.enable = true;

    hardware.graphics.enable = true;
  };
}
