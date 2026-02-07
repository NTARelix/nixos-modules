# The primary editor of the system: Neovim (https://neovim.io/).
# Configured via `./editor/init.lua`.
# Run in any shell with `vi`, `vim`, or `nvim`.
# Uses NixOS to install all plugins and language servers.
{ pkgs, ... }:
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
        codecompanion-nvim
        codecompanion-spinner-nvim
        conform-nvim
        fidget-nvim
        gitsigns-nvim
        lazydev-nvim
        lualine-nvim
        markdown-preview-nvim
        nvim-lspconfig
        nightfox-nvim
        nvim-tree-lua
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
    basedpyright
    bash-language-server
    bc
    dotenv-linter
    eslint_d
    hadolint
    lua-language-server
    prettierd
    nil
    statix
    stylelint
    stylua
    tailwindcss-language-server
    terraform-ls
    typescript-go
    vscode-langservers-extracted
    vtsls
    vue-language-server
    yaml-language-server
  ];
}
