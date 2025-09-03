# The primary version control system: Git (https://git-scm.com/).
# Run in any shell with `git`.
# Configured almost completely from NixOS.
# Remote repos may require stateful key management outside of the NixOS config.
# I.e. `ssh-keygen` and `~/.ssh`.
{ ... }:
{
    programs.git = {
        enable = true;
        config = {
            alias.amend = "commit --amend --no-edit --reset-author";
            alias.stauts = "status";
            alias.statsu = "status";
            core.excludesFile = "~/.gitignore";
            core.pager = "less -FX";
            diff.algorithm = "patience";
            merge.conflictStyle = "diff3";
            merge.ff = "only";
            pull.rebase = true;
            push.autoSetupRemote = true;
            user.name = "Kevin Koshiol";
        };
    };
}

