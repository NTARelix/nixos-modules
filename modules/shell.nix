# The primary shell.
# Makes terminal use much friendlier than most defaults.
# RECOMMENDED: configure your terminal to use a particular font as specified by p10k:
#    https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#fonts
# Configured here with NixOS, as well as a generated p10k theme config in `./shell/p10k.zsh`.
# Also adds tools for command-line convenience.
# All plugins are managed here with NixOS.
{ lib, pkgs, ... }:
let
    oldPkgs = import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/42b35e98c168781a208b31b5095bdb0f336b410a.tar.gz";
    }) {};
in
{
    # Packages
    environment.systemPackages = with pkgs; [
        # oldPkgs because https://github.com/NixOS/nixpkgs/issues/437525
        (oldPkgs.azure-cli.withExtensions [
            oldPkgs.azure-cli.extensions.containerapp
            oldPkgs.azure-cli.extensions.log-analytics
        ])
        # devenv
        fzf
        nodejs_24
        ripgrep
        terraform
    ];
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "terraform"
    ];

    # Direnv
    # programs.direnv = {
    #     enable = true;
    #     enableZshIntegration = true;
    #     nix-direnv.enable = true;
    # };
    nix.extraOptions = ''
        trusted-users = root nixos
    '';

    # Shell
    users.extraUsers.nixos.shell = pkgs.zsh;
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;
        histSize = 100000;
        histFile = "$HOME/.zsh_history";
        interactiveShellInit = ''
            source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
            source ${pkgs.fzf}/share/fzf/key-bindings.zsh
            source ${pkgs.fzf}/share/fzf/completion.zsh
        '';
        ohMyZsh = {
            enable = true;
            plugins = [
                "bgnotify"
                "branch"
                "common-aliases"
                "docker"
                "fzf"
                "git"
                "nodenv"
                "npm"
                "safe-paste"
                "ssh"
                "sudo"
                "z"
            ];
        };
    };

    # Prompt
    programs.starship.enable = true;
}

