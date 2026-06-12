{ inputs, ... }: {
  flake.nixosModules.stylix = { pkgs, ... }: {
    imports = [
      inputs.stylix.nixosModules.stylix
    ];

    stylix = {
      enable = true;

      polarity = "dark";

      base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

      fonts = {
        serif = {
          package = pkgs.noto-fonts;
          name = "Noto Serif";
        };

        sansSerif = {
          package = pkgs.noto-fonts;
          name = "Noto Sans";
        };

        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };

        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 16;
      };
    };

    stylix.enableReleaseChecks = false;

    stylix.targets = {
      nixvim.enable = true;
      kmscon.enable = false;
      qt.enable = false;
      regreet.extraCss = ''
        window {
          background-color: @window_bg_color;
        }

        .clock {
          font-size: 72px;
          font-weight: 300;
          margin-bottom: 4px;
        }

        entry {
          border-radius: 8px;
          padding: 10px 14px;
        }

        entry:focus {
          box-shadow: 0 0 0 2px alpha(@accent_bg_color, 0.35);
        }

        button {
          border-radius: 8px;
          padding: 8px 18px;
        }

        combobox > button,
        dropdown > button {
          border-radius: 8px;
        }
      '';
    };
  };
}
