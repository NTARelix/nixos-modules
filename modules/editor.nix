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
            rev = "f9ca2a1d8ee34a19f21b909d1164c7b52a8f17c3";
            sha256 = "sha256-kzHz+zUiPc2NgI5olgu0pyBnfUVk2+k9fB882ny+mpw=";
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
                lua package.path = "/etc/nixos-modules/modules/editor/?.lua;" .. package.path
                lua dofile('/etc/nixos-modules/modules/editor/init.lua')
            '';
            packages.myVimPackages.start = with pkgs.vimPlugins; [
                blink-cmp
                bufferline-nvim
                fidget-nvim
                gitsigns-nvim
                grug-far-nvim
                lazydev-nvim
                lualine-nvim
                nvim-lspconfig
                nightfox-nvim
                none-ls-nvim
                nvim-tree-lua
                nvim-treesitter-textobjects
                nvim-treesitter.withAllGrammars
                nvim-web-devicons
                SchemaStore-nvim
                telescope-nvim
                vim-fugitive
                vim-visual-multi
                which-key-nvim
            ];
        };
    };
    environment.systemPackages = with pkgs; [
        bash-language-server
        dotenv-linter
        hadolint
        lua-language-server
        nil
        prettierd
        statix
        stylelint
        tailwindcss-language-server
        terraform-ls
        # tsgo
        vscode-langservers-extracted
        vtsls
        vue-language-server
        yamllint
    ];
}

