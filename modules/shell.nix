# The primary shell.
# Makes terminal use much friendlier than most defaults.
# RECOMMENDED: configure your terminal to use a particular font as specified by p10k:
#    https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#fonts
# Configured here with NixOS, as well as a generated p10k theme config in `./shell/p10k.zsh`.
# Also adds tools for command-line convenience.
# All plugins are managed here with NixOS.
{
  pkgs,
  ...
}:
{
  # Packages
  environment.localBinInPath = true;
  environment.systemPackages = with pkgs; [
    herdr
    fzf
    jq
    man-pages
    nodejs_24
    ripgrep
    unzip
  ];
  environment.sessionVariables = {
    HERDR_CONFIG_PATH = "/etc/nixos-modules/modules/herdr/config.toml";
  };

  # Direnv
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # Shell
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 100000;
    histFile = "$HOME/.zsh_history";
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
        "z"
      ];
    };
  };
  programs.fzf = {
    keybindings = true;
    fuzzyCompletion = true;
  };

  # Prompt
  programs.starship.enable = true;

  # Multiplexer
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    historyLimit = 10000;
    keyMode = "vi";
    shortcut = "Space";
    terminal = "tmux-256color";
    plugins = with pkgs.tmuxPlugins; [
      gruvbox
    ];
    extraConfig = ''
      set -g mouse on
      set -g status-right ""
      set -g status-right-length 0
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -as terminal-overrides ',xterm-256color:Smulx=\E[4::%p1%dm'  # undercurl support
      set -s escape-time 0
      set -g renumber-windows on
      set -g focus-events on
      bind-key C-Space send-prefix
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      bind -r H resize-pane -L
      bind -r J resize-pane -D
      bind -r K resize-pane -U
      bind -r L resize-pane -R
      bind -T copy-mode-vi WheelUpPane send-keys -X scroll-up
      bind -T copy-mode-vi WheelDownPane send-keys -X scroll-down
    '';
  };
}
