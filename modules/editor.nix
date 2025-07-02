# The primary editor of the system: Neovim (https://neovim.io/).
# Configured via `./editor/init.lua`.
# Run in any shell with `vi`, `vim`, or `nvim`.
# Uses NixOS to install all plugins and language servers.
{ config, lib, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    configure = {
      customRC = ''
        lua dofile('/etc/nixos-modules-flake/modules/editor/init.lua')
      '';
      packages.myVimPackages.start = with pkgs.vimPlugins; [
        gitsigns-nvim
        lualine-nvim
        nvim-lspconfig
        nvim-cmp
        nvim-tree-lua
        nvim-treesitter.withAllGrammars
        nvim-treesitter-textobjects
        nvim-web-devicons
        telescope-nvim
        vim-visual-multi
        which-key-nvim
      ];
    };
  };
  environment.systemPackages = with pkgs; [
    typescript-language-server
    vue-language-server
  ];
}

