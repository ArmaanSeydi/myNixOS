{ ... }: {

  flake.homeModules.nixvim = { ... }: {
    programs.nixvim = {
      enable = true;

      opts = {
        number = true;
        relativenumber = true;

        shiftwidth = 2;
        tabstop = 2;
        expandtab = true;

        mouse = "a";

        ignorecase = true;
        smartcase = true;

        clipboard = "unnamedplus";
      };

      globals.mapleader = " ";

      plugins = {
        lualine.enable = true;
        treesitter.enable = true;
        telescope.enable = true;

        web-devicons.enable = true;

        cmp = {
          enable = true;
          autoEnableSources = true;
        };

        luasnip.enable = true;

        nix.enable = true;
      };

      keymaps = [
        {
          mode = "n";
          key = "<leader>ff";
          action = "<cmd>Telescope find_files<CR>";
        }
        {
          mode = "n";
          key = "<leader>fg";
          action = "<cmd>Telescope live_grep<CR>";
        }
      ];
    };
  };
}
