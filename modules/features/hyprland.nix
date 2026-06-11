{ self, ... }: {
  flake.nixosModules.hyprland = { pkgs, ... }: {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = pkgs.hyprland.overrideAttrs (old: {
        postInstall = (old.postInstall or "") + ''
          rm -f $out/share/wayland-sessions/hyprland-uwsm.desktop
        '';
      });
    };

    hardware.graphics.enable = true;
  };
}
