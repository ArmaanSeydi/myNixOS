{ self, ... }: {
  flake.nixosModules.fonts = { pkgs, ... }: {
    fonts = {
      enableDefaultPackages = true;

      packages = with pkgs; [
        # Noto — covers virtually every script on earth
        noto-fonts           # Latin, Greek, Cyrillic, Arabic, Hebrew, and more
        noto-fonts-cjk-sans  # Chinese, Japanese, Korean (sans)
        noto-fonts-cjk-serif # Chinese, Japanese, Korean (serif)
        noto-fonts-color-emoji
        noto-fonts           # additional Noto script coverage

        # Windows metric-compatible (Arial, Times New Roman, Courier New)
        liberation_ttf

        # Extended Unicode fallback
        dejavu_fonts
        unifont # covers the entire Unicode BMP as a last-resort fallback

        # Bitmap / pixel fonts
        tewi-font
        envypn-font
        gohufont

        # Programmer monospace
        iosevka-bin
      ];

      fontconfig = {
        enable = true;
        defaultFonts = {
          sansSerif = [ "Noto Sans" "Noto Sans CJK SC" ];
          serif     = [ "Noto Serif" "Noto Serif CJK SC" ];
          monospace = [ "JetBrainsMono Nerd Font" "Noto Sans Mono CJK SC" ];
          emoji     = [ "Noto Color Emoji" ];
        };
      };
    };
  };
}
