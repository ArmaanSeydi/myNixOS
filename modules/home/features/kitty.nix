{ lib, ... }: {
  flake.homeModules.kitty = { lib, ... }: {
    xdg.desktopEntries.kitty = {
      name = "kitty";
      genericName = "Terminal Emulator";
      exec = "kitty --start-as=maximized %F";
      icon = "kitty";
      comment = "Fast, feature-rich, GPU based terminal";
      categories = [ "System" "TerminalEmulator" ];
      terminal = false;
    };

    programs.kitty = {
      enable = true;

      shellIntegration.enableZshIntegration = true;

      settings = {
        shell = "zsh";
        # Window chrome
        hide_window_decorations    = "yes";
        confirm_os_window_close    = 0;
        window_padding_width       = 14;
        placement_strategy         = "center";

        # Cursor
        cursor_shape               = "block";
cursor_blink_interval      = "0.5";
        cursor_stop_blinking_after = "15.0";

        # Subtle transparency
        background_opacity         = lib.mkForce "0.94";
        dynamic_background_opacity = "yes";

        # Tab bar
        tab_bar_style              = "powerline";
        tab_powerline_style        = "slanted";
        tab_title_template         = "{index}: {title}";

        # Font refinements (stylix sets family + size)
        font_features              = "JetBrainsMonoNerdFont-Regular +liga +calt";
        disable_ligatures          = "never";

        # Scrollback
        scrollback_lines           = 10000;

        # Bells — off
        enable_audio_bell          = "no";
        visual_bell_duration       = "0.0";

        # Performance
        repaint_delay              = 10;
        input_delay                = 3;
        sync_to_monitor            = "yes";
      };

      keybindings = {
        "super+q" = "close_os_window";
      };
    };
  };
}
