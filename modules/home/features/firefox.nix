{ lib, ... }: {
  flake.homeModules.firefox = { config, ... }: {
    stylix.targets.firefox.profileNames = [ "armaan" ];

    programs.firefox = {
      enable = true;
      profiles.armaan = {
        isDefault = true;
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "sidebar.revamp" = true;
          "sidebar.verticalTabs" = true;
        };
        userChrome =
          let
            c = config.lib.stylix.colors;
          in
          ''
            :root {
              --bg:      #${c.base00-hex};
              --bg-alt:  #${c.base01-hex};
              --bg-alt2: #${c.base02-hex};
              --fg:      #${c.base05-hex};
              --accent:  #${c.base0D-hex};
            }

            #titlebar { display: none; }
            .urlbar-input-box { text-align: center; }
            #nav-bar { margin: 3px; }
            #urlbar:not([focused]) #urlbar-background { opacity: 0 !important; }

            * { font-family: monospace; }

            .browserContainer browser {
              border-radius: 5px !important;
            }

            #navigator-toolbox {
              max-height: 2vh;
              background-color: var(--bg) !important;
              color: var(--fg) !important;
              border-bottom: none !important;

              & * { opacity: 0; }
            }

            #navigator-toolbox:hover {
              max-height: 100vh;
              height: auto;

              & * { opacity: 1; }
            }

            #urlbar-background {
              background-color: var(--bg-alt) !important;
            }
          '';
      };
    };
  };
}
