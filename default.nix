let
    modules = {
        editor = import ./modules/editor.nix;
        git = import ./modules/git.nix;
        oci = import ./modules/oci.nix;
        shell = import ./modules/shell.nix;
        azure-cli = import ./modules/azure-cli.nix;
        terraform-cli = import ./modules/terraform-cli.nix;
    };
in
modules
