
{ config, lib, pkgs, ... }:
{
  programs.git = {
    enable = true;
    config = {
      core.excludesFile = "~/.gitignore";
      diff.algorithm = "patience";
      merge.conflictStyle = "diff3";
      merge.ff = "only";
      push.autoSetupRemote = true;
      user.name = "Kevin Koshiol";
    };
  };
}

