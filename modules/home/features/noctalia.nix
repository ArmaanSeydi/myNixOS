{ self, ... }: {
  flake.homeModules.noctalia = { lib, ... }: {

    programs.noctalia-shell = {
      enable = true;

      settings = {
        settingsVersion = 59;

        appLauncher = {
          density = "compact";
          enableClipboardHistory = true;
          iconMode = "native";
          overviewLayer = true;
          showCategories = false;
        };

        bar = {
          backgroundOpacity = lib.mkForce 0;
          density = "comfortable";
          showCapsule = false;
          widgets = {
            left = [
              {
                id = "Launcher";
                colorizeSystemIcon = "primary";
                colorizeSystemText = "none";
                customIconPath = "";
                enableColorization = true;
                icon = "rocket";
                iconColor = "none";
                useDistroLogo = true;
              }
              {
                id = "ActiveWindow";
                colorizeIcons = false;
                hideMode = "hidden";
                maxWidth = 250;
                scrollingMode = "hover";
                showIcon = true;
                showText = true;
                textColor = "none";
                useFixedWidth = false;
              }
              {
                id = "MediaMini";
                compactMode = false;
                hideMode = "hidden";
                hideWhenIdle = false;
                maxWidth = 250;
                panelShowAlbumArt = true;
                scrollingMode = "hover";
                showAlbumArt = true;
                showArtistFirst = true;
                showProgressRing = true;
                showVisualizer = true;
                textColor = "none";
                useFixedWidth = false;
                visualizerType = "mirrored";
              }
            ];
            center = [
              {
                id = "Workspace";
                characterCount = 2;
                colorizeIcons = false;
                emptyColor = "primary";
                enableScrollWheel = true;
                focusedColor = "tertiary";
                followFocusedScreen = false;
                fontWeight = "bold";
                groupedBorderOpacity = 1;
                hideUnoccupied = false;
                iconScale = 0.8;
                labelMode = "none";
                occupiedColor = "primary";
                pillSize = 0.43;
                showApplications = false;
                showApplicationsHover = false;
                showBadge = true;
                showLabelsOnlyWhenOccupied = true;
                unfocusedIconsOpacity = 1;
              }
            ];
            right = [
              {
                id = "Clock";
                clockColor = "none";
                customFont = "JetBrainsMono NF";
                formatHorizontal = "HH:mm";
                formatVertical = "HH mm - dd MM";
                tooltipFormat = "HH:mm ddd, MMM dd";
                useCustomFont = true;
              }
              {
                id = "Tray";
                blacklist = [ ];
                chevronColor = "none";
                colorizeIcons = false;
                drawerEnabled = true;
                hidePassive = false;
                pinned = [ ];
              }
              {
                id = "NotificationHistory";
                hideWhenZero = false;
                hideWhenZeroUnread = false;
                iconColor = "none";
                showUnreadBadge = true;
                unreadBadgeColor = "primary";
              }
              {
                id = "Network";
                displayMode = "onhover";
                iconColor = "none";
                textColor = "none";
              }
              {
                id = "Battery";
                deviceNativePath = "__default__";
                displayMode = "graphic-clean";
                hideIfIdle = false;
                hideIfNotDetected = true;
                showNoctaliaPerformance = true;
                showPowerProfiles = true;
              }
              {
                id = "ControlCenter";
                colorizeDistroLogo = false;
                colorizeSystemIcon = "primary";
                colorizeSystemText = "none";
                customIconPath = "";
                enableColorization = true;
                icon = "anchor";
                useDistroLogo = false;
              }
            ];
          };
        };

        # Empty string = no predefined scheme applied; noctalia uses colors.json as-is (set by stylix).
        colorSchemes = {
          predefinedScheme = "";
          darkMode = true;
        };

        controlCenter = {
          cards = [
            { id = "profile-card"; enabled = true; }
            { id = "shortcuts-card"; enabled = true; }
            { id = "audio-card"; enabled = true; }
            { id = "brightness-card"; enabled = true; }
            { id = "weather-card"; enabled = true; }
            { id = "media-sysmon-card"; enabled = true; }
          ];
          shortcuts = {
            left = [
              { id = "Bluetooth"; }
              { id = "KeepAwake"; }
              { id = "NightLight"; }
              { id = "DarkMode"; }
            ];
            right = [ ];
          };
        };

        desktopWidgets = {
          enabled = true;
          gridSnap = true;
          monitorWidgets = [
            {
              name = "eDP-1";
              widgets = [
                {
                  id = "AudioVisualizer";
                  colorName = "primary";
                  height = 300;
                  hideWhenIdle = true;
                  roundedCorners = false;
                  scale = 1.9217431520592139;
                  showBackground = false;
                  visualizerType = "linear";
                  width = 800;
                  x = 0;
                  y = 448;
                }
              ];
            }
          ];
        };

        dock.enabled = false;

        general = {
          enableBlurBehind = false;
          lockScreenAnimations = true;
          lockScreenBlur = 0.3;
          lockScreenTint = 0.3;
          passwordChars = true;
          shadowDirection = "center";
          shadowOffsetX = 0;
          shadowOffsetY = 0;
        };

        idle = {
          enabled = true;
          lockTimeout = 605;
        };

        location.name = "Tehran";

        notifications = {
          backgroundOpacity = lib.mkForce 0.9;
          density = "compact";
        };

        osd = {
          backgroundOpacity = lib.mkForce 0.9;
          location = "bottom_right";
        };

        sessionMenu = {
          largeButtonsStyle = false;
          position = "top_right";
          showHeader = false;
        };

        ui = {
          panelBackgroundOpacity = lib.mkForce 1;
          scrollbarAlwaysVisible = false;
          translucentWidgets = true;
        };

        wallpaper.directory = "/home/armaan/Documents/myNixOS/wallpapers";
      };
    };
  };
}
