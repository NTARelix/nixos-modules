
{ config, lib, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    configure = {
      customRC = ''
        lua dofile('/etc/nixos-flakes/modules/editor/init.lua')
      '';
      packages.myVimPackages.start = with pkgs.vimPlugins; [
        gitsigns-nvim
        lualine-nvim
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
}

