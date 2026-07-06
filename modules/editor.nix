# The primary editor of the system: Neovim (https://neovim.io/).
# Configured via `./editor/init.lua`.
# Run in any shell with `vi`, `vim`, or `nvim`.
# Uses NixOS to install all plugins and language servers.
{ pkgs, ... }:
let
  apex-lsp-jar = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/forcedotcom/salesforcedx-vscode/develop/packages/salesforcedx-vscode-apex/jars/apex-jorje-lsp.jar";
    sha256 = "sha256-JUnD/zu6dUtc6eSUciSJRu6cKe9kt+zVEvpttuqsICc=";
  };
  tree-sitter-apex = pkgs.tree-sitter.buildGrammar {
    language = "apex";
    version = "unstable-2026-07-06";
    src = pkgs.fetchFromGitHub {
      owner = "aheber";
      repo = "tree-sitter-sfapex";
      rev = "27a3091a1a444ce19d6099e00cd3788f019d0c2b";
      hash = "sha256-Pg8zZmjGFcLftPNPiASt0uUxYG6CRcsB9qKhTMC5G7U=";
    };
    location = "apex";
  };
  helix-runtime-with-apex = pkgs.runCommand "helix-runtime-with-apex" {} ''
    mkdir -p $out/grammars $out/queries
    cp -r ${pkgs.helix.runtime}/queries/. $out/queries/
    cp -r ${pkgs.helix.runtime}/grammars/. $out/grammars/
    chmod -R u+w $out
    install -Dm444 ${tree-sitter-apex}/parser $out/grammars/apex.so
    mkdir -p $out/queries/apex
    cp ${tree-sitter-apex}/queries/*.scm $out/queries/apex/
  '';
  helix-custom-unwrapped = pkgs.helix.overrideAttrs (old: {
    src = pkgs.fetchFromGitHub {
      owner = "helix-editor";
      repo = "helix";
      rev = "1cbad945984e8409d3872b070afbb25fda525a5f";
      hash = "sha256-NDpCGVn6FYEnkgU6owOQV3OLYPd+NXu0iLN1+6Rwj78=";
    };
  });
  helix_custom = pkgs.symlinkJoin {
    name = "helix_custom";
    paths = with pkgs; [
      helix-custom-unwrapped
      tailwindcss-language-server
      tombi
      typescript-go
      vscode-langservers-extracted
      vtsls
    ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      rm $out/bin/hx
      makeWrapper "$(readlink -f ${helix-custom-unwrapped}/bin/.hx-wrapped)" $out/bin/hx \
        --set XDG_CONFIG_HOME "/etc/nixos-modules/modules/xdg-config-home" \
        --set-default XDG_DATA_HOME "\$HOME/.local/share" \
        --set-default XDG_CACHE_HOME "\$HOME/.cache" \
        --prefix PATH : "${pkgs.jdk17}/bin" \
        --set HELIX_RUNTIME "${helix-runtime-with-apex}"
    '';
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
        conform-nvim
        codediff-nvim
        fidget-nvim
        gitsigns-nvim
        lazydev-nvim
        lualine-nvim
        markdown-preview-nvim
        nightfox-nvim
        nvim-lspconfig
        nvim-tree-lua
        nvim-treesitter.withAllGrammars
        nvim-web-devicons
        SchemaStore-nvim
        telescope-nvim
        telescope-ui-select-nvim
        vim-fugitive
        vim-visual-multi
        which-key-nvim
      ];
    };
  };
  environment.etc = {
    "vue-typescript-plugin".source =
      "${pkgs.vue-language-server}/lib/language-tools/packages/language-server";
    "apex-jorje-lsp.jar".source = "${apex-lsp-jar}";
  };
  environment.systemPackages = with pkgs; [
    basedpyright
    bash-language-server
    bc
    dotenv-linter
    eslint_d
    hadolint
    helix_custom
    jdt-language-server
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
