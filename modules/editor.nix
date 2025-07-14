# The primary editor of the system: Neovim (https://neovim.io/).
# Configured via `./editor/init.lua`.
# Run in any shell with `vi`, `vim`, or `nvim`.
# Uses NixOS to install all plugins and language servers.
{ pkgs, ... }:
let
    tsgo = pkgs.buildGoModule {
        pname = "tsgo";
        version = "unstable-2025-07-12";
        src = pkgs.fetchFromGitHub {
            owner = "microsoft";
            repo = "typescript-go";
            rev = "2b82831a05b6b99da279d12fecbcbc460574a85b";
            sha256 = "sha256-psDVrF3NNeL+Y6dM6kjDKX+ThIysnzJkxDQjKvAs/9M=";
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
                none-ls-nvim
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
        dotenv-linter
        hadolint
        lua-language-server
        nil
        prettierd
        statix
        stylelint
        tsgo
        vtsls
        vue-language-server
        yamllint
    ];
}

