# The primary version control system: Git (https://git-scm.com/).
# Run in any shell with `git`.
# Configured almost completely from NixOS.
# Remote repos may require stateful key management outside of the NixOS config.
# I.e. `ssh-keygen` and `~/.ssh`.
{ config, lib, pkgs, ... }:
{
    programs.git = {
        enable = true;
        config = {
            core.excludesFile = "~/.gitignore";
            core.pager = "less -FX";
            diff.algorithm = "patience";
            merge.conflictStyle = "diff3";
            merge.ff = "only";
            push.autoSetupRemote = true;
            user.name = "Kevin Koshiol";
        };
    };
}

