
{ config, lib, pkgs, ... }:
{
  # Packages
  environment.systemPackages = with pkgs; [
  #  devenv
    fzf
    ripgrep
  ];

  # Direnv
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
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
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh
      source ${pkgs.fzf}/share/fzf/completion.zsh
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ${./shell/p10k.zsh}
    '';
    ohMyZsh = {
      enable = true;
      plugins = [
        "bgnotify"
        "branch"
        "common-aliases"
        "docker"
        "nodenv"
        "npm"
        "fzf"
        "git"
        "safe-paste"
        "ssh"
        "sudo"
        "z"
      ];
    };
  };
}

