{ ... }: {
  flake.homeModules.hyprland = { pkgs, lib, ... }: {

    wayland.windowManager.hyprland = {
      enable = true;
      configType = "hyprlang";
      xwayland.enable = true;

      settings = {
        monitor = ",preferred,auto,1";

        env = [
          "XCURSOR_THEME,Bibata-Modern-Ice"
          "XCURSOR_SIZE,16"
        ];

        general = {
          gaps_in   = 4;
          gaps_out  = 8;
          border_size = 2;
          "col.active_border"   = lib.mkForce "rgba(88C0D0ff) rgba(81A1C1ff) 45deg";
          "col.inactive_border" = lib.mkForce "rgba(4C566Aff)";
          layout = "dwindle";
        };

        decoration = {
          rounding = 8;
          blur = {
            enabled = true;
            size    = 5;
            passes  = 2;
          };
          shadow.enabled = false;
        };

        animations = {
          enabled = true;
          bezier = "smooth, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows,    1, 5, smooth"
            "windowsOut, 1, 5, default, popin 80%"
            "border,     1, 10, default"
            "fade,       1, 5, default"
            "workspaces, 1, 5, default"
          ];
        };

        input = {
          kb_layout = "us";
          follow_mouse = 1;
          sensitivity = 0;
          touchpad = {
            natural_scroll = true;
            tap-to-click   = true;
          };
        };

        dwindle = {
          preserve_split = true;
        };

        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo   = true;
        };


        bind =
          [
            "SUPER,       Return, exec,          kitty"
            "SUPER,       Q,      killactive"
            "SUPER,       M,      exit"
            "SUPER,       V,      togglefloating"
            "SUPER,       F,      fullscreen"
            "SUPER,       R,      exec,          wofi --show drun"
            "SUPER,       P,      pseudo"

            # Focus (vim-style)
            "SUPER,       H, movefocus, l"
            "SUPER,       L, movefocus, r"
            "SUPER,       K, movefocus, u"
            "SUPER,       J, movefocus, d"

            # Move windows
            "SUPER SHIFT, H, movewindow, l"
            "SUPER SHIFT, L, movewindow, r"
            "SUPER SHIFT, K, movewindow, u"
            "SUPER SHIFT, J, movewindow, d"

            # Screenshot: region → clipboard
            "SUPER SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy"
            ",            Print, exec, grim - | wl-copy"

            # Clipboard history
            "SUPER SHIFT, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"

            # Caelestia settings (Nexus)
            "SUPER, I, exec, caelestia shell \"nexus.open()\""

          ]
          ++ (map (n: "SUPER,       ${toString n}, workspace,       ${toString n}") (lib.range 1 9))
          ++ [ "SUPER,       0, workspace,       10" ]
          ++ (map (n: "SUPER SHIFT, ${toString n}, movetoworkspace, ${toString n}") (lib.range 1 9))
          ++ [ "SUPER SHIFT, 0, movetoworkspace, 10" ];

        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];

        bindel = [
          ", XF86AudioRaiseVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume,  exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute,         exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioPlay,         exec, playerctl play-pause"
          ", XF86AudioNext,         exec, playerctl next"
          ", XF86AudioPrev,         exec, playerctl previous"
          ", XF86MonBrightnessUp,   exec, brightnessctl set +10%"
          ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
        ];

        "exec-once" = [
          "hyprpaper"
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        ];
      };
    };

    # Wallpaper
    xdg.configFile."hypr/hyprpaper.conf".text = ''
      preload = ~/Documents/myNixOS/wallpapers/nord-apple.jpg
      wallpaper = ,~/Documents/myNixOS/wallpapers/nord-apple.jpg
      splash = false
    '';

    home.packages = with pkgs; [
      wofi
      hyprpaper
      grim
      slurp
    ];

    # Desktop shell — replaces Waybar, mako, hyprlock, and hypridle
    programs.caelestia = {
      enable = true;
      cli.enable = true;
    };

    gtk = {
      enable = true;
      iconTheme = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
      };
    };

    # Clipboard history (Super+Shift+V to paste from history)
    services.cliphist.enable = true;
  };
}
