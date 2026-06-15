{ ... }: {
  flake.homeModules.niri = { pkgs, config, ... }: {

    home.packages = with pkgs; [
      swaybg
      grim
      slurp
      fuzzel
      xwayland-satellite
    ];

    services.cliphist.enable = true;

    gtk = {
      enable = true;
      iconTheme = {
        package = pkgs.nordzy-icon-theme;
        name = "Nordzy-dark";
      };
    };

    xdg.configFile."niri/config.kdl".text =
      let
        c = config.lib.stylix.colors;
        noctalia = "${config.programs.noctalia-shell.package}/bin/noctalia-shell";
        kitty = "${pkgs.kitty}/bin/kitty";
        swaybg = "${pkgs.swaybg}/bin/swaybg";
        wpctl = "${pkgs.wireplumber}/bin/wpctl";
        playerctl = "${pkgs.playerctl}/bin/playerctl";
        brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
      in ''
      environment {
          XCURSOR_THEME "Bibata-Modern-Ice"
          XCURSOR_SIZE "16"
          DISPLAY ":0"
      }

      prefer-no-csd

      input {
          keyboard {
              xkb {
                  layout "us"
              }
          }
          touchpad {
              natural-scroll
              tap
          }
          mouse {
          }

          focus-follows-mouse
          warp-mouse-to-focus
      }

      window-rule {
          geometry-corner-radius 12
          clip-to-geometry true
      }

      window-rule {
          match is-focused=true
          opacity 0.9
      }

      window-rule {
          match is-focused=false
          opacity 0.75
      }

      layout {
          gaps 12

          default-column-width { proportion 0.5; }

          focus-ring {
              width 2
              active-gradient from="#${c.base0D}" to="#${c.base0C}" angle=45
              inactive-color "#${c.base03}"
          }

          border {
              off
          }

          shadow {
              on
              softness 30
              spread 5
              offset x=0 y=4
              color "#${c.base00}99"
          }
      }

      // Transparent backdrop lets the wallpaper show through in overview
      overview {
          backdrop-color "#${c.base00}00"
      }

      animations {
          workspace-switch {
              spring damping-ratio=1.0 stiffness=1000 epsilon=0.0001
          }
          window-open {
              duration-ms 150
              curve "ease-out-expo"
          }
          window-close {
              duration-ms 150
              curve "ease-out-quad"
          }
          window-movement {
              spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
          }
          window-resize {
              spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
          }
          horizontal-view-movement {
              spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
          }
      }

      binds {
          // Core
          Mod+Return { spawn "${kitty}"; }
          Mod+Q { close-window; }
          Mod+Shift+E { quit; }
          Mod+V { toggle-window-floating; }
          Mod+F { fullscreen-window; }
          Mod+C { center-column; }
          Mod+Tab { focus-workspace-previous; }
          Mod+W { toggle-overview; }

          // Noctalia
          Mod+R { spawn "${noctalia}" "ipc" "call" "launcher" "toggle"; }
          Mod+I { spawn "${noctalia}" "ipc" "call" "controlCenter" "toggle"; }

          // Focus (vim-style)
          Mod+H { focus-column-left; }
          Mod+L { focus-column-right; }
          Mod+K { focus-window-up; }
          Mod+J { focus-window-down; }

          // Move windows
          Mod+Shift+H { move-column-left; }
          Mod+Shift+L { move-column-right; }
          Mod+Shift+K { move-window-up; }
          Mod+Shift+J { move-window-down; }

          // Resize columns and windows
          Mod+Minus { set-column-width "-10%"; }
          Mod+Equal { set-column-width "+10%"; }
          Mod+Shift+Minus { set-window-height "-10%"; }
          Mod+Shift+Equal { set-window-height "+10%"; }

          // Stack/unstack windows in a column
          Mod+Comma { consume-window-into-column; }
          Mod+Period { expel-window-from-column; }

          // Workspaces
          Mod+1 { focus-workspace 1; }
          Mod+2 { focus-workspace 2; }
          Mod+3 { focus-workspace 3; }
          Mod+4 { focus-workspace 4; }
          Mod+5 { focus-workspace 5; }
          Mod+6 { focus-workspace 6; }
          Mod+7 { focus-workspace 7; }
          Mod+8 { focus-workspace 8; }
          Mod+9 { focus-workspace 9; }
          Mod+0 { focus-workspace 10; }

          Mod+Shift+1 { move-window-to-workspace 1; }
          Mod+Shift+2 { move-window-to-workspace 2; }
          Mod+Shift+3 { move-window-to-workspace 3; }
          Mod+Shift+4 { move-window-to-workspace 4; }
          Mod+Shift+5 { move-window-to-workspace 5; }
          Mod+Shift+6 { move-window-to-workspace 6; }
          Mod+Shift+7 { move-window-to-workspace 7; }
          Mod+Shift+8 { move-window-to-workspace 8; }
          Mod+Shift+9 { move-window-to-workspace 9; }
          Mod+Shift+0 { move-window-to-workspace 10; }

          // Screenshots (built-in niri actions)
          Mod+Shift+S { screenshot; }
          Print { screenshot-screen; }

          // Clipboard history
          Mod+Shift+V { spawn "sh" "-c" "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"; }

          // Screen lock
          Ctrl+Alt+L { spawn "${noctalia}" "ipc" "call" "lockScreen" "lock"; }

          // Audio
          XF86AudioRaiseVolume allow-when-locked=true { spawn "${wpctl}" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
          XF86AudioLowerVolume allow-when-locked=true { spawn "${wpctl}" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
          XF86AudioMute allow-when-locked=true { spawn "${wpctl}" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
          XF86AudioPlay { spawn "${playerctl}" "play-pause"; }
          XF86AudioNext { spawn "${playerctl}" "next"; }
          XF86AudioPrev { spawn "${playerctl}" "previous"; }

          // Brightness
          XF86MonBrightnessUp { spawn "${brightnessctl}" "set" "+5%"; }
          XF86MonBrightnessDown { spawn "${brightnessctl}" "set" "5%-"; }
      }

      spawn-at-startup "${swaybg}" "-i" "${../../../wallpapers/nord-apple.jpg}" "-m" "fill"
      spawn-at-startup "${noctalia}"
      spawn-at-startup "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
      spawn-at-startup "${pkgs.xwayland-satellite}/bin/xwayland-satellite"
    '';
  };
}
