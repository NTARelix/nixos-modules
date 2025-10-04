let
    modules = {
        editor = import ./modules/editor.nix;
        git = import ./modules/git.nix;
        oci = import ./modules/oci.nix;
        shell = import ./modules/shell.nix;
    };
in
modules
