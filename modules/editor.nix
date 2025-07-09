# The primary editor of the system: Neovim (https://neovim.io/).
# Configured via `./editor/init.lua`.
# Run in any shell with `vi`, `vim`, or `nvim`.
# Uses NixOS to install all plugins and language servers.
{ config, lib, pkgs, ... }:
let
    tsgo = pkgs.buildGoModule {
        pname = "tsgo";
        version = "unstable-2025-07-07";
        src = pkgs.fetchFromGitHub {
            owner = "microsoft";
            repo = "typescript-go";
            rev = "742fcd2fcddf43cf3b68201538c783f2bf488ea3";
            sha256 = "sha256-kOLZTSbb7MUbJgMS2Gag85mjwZntS1ZfUUT+K+NTRQQ=";
        };
        vendorHash = "sha256-9gZ1h/rsJ5DEcU8CJGKszE98GzZqfs2ELp1lbXsliYk=";
    };
in
{
    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        defaultEditor = true;
        configure = {
            customRC = ''
                lua package.path = "/etc/nixos-modules-flake/modules/editor/?.lua;" .. package.path
                lua dofile('/etc/nixos-modules-flake/modules/editor/init.lua')
            '';
            packages.myVimPackages.start = with pkgs.vimPlugins; [
                blink-cmp
                vim-fugitive
                gitsigns-nvim
                lazydev-nvim
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
        };
    };
    environment.systemPackages = with pkgs; [
        lua-language-server
        nil
        tsgo
        vue-language-server
    ];
}

