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
            packages.myVimPackages = {
                start = with pkgs.vimPlugins; [
                    lualine-nvim
                    nightfox-nvim
                    nvim-tree-lua
                    nvim-treesitter-textobjects
                    nvim-treesitter.withAllGrammars
                    nvim-web-devicons
                    telescope-nvim
                    vim-visual-multi
                    which-key-nvim
                ];
                opt = with pkgs.vimPlugins; [
                    gitsigns-nvim
                    nvim-cmp
                    nvim-lspconfig
                ];
            };
        };
    };
    environment.systemPackages = with pkgs; [
        typescript-language-server
        vue-language-server
    ];
}

