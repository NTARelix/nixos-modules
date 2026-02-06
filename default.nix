let
  modules = {
    azure-cli = import ./modules/azure-cli.nix;
    editor = import ./modules/editor.nix;
    git = import ./modules/git.nix;
    oci = import ./modules/oci.nix;
    plantuml = import ./modules/plantuml.nix;
    shell = import ./modules/shell.nix;
    terraform-cli = import ./modules/terraform-cli.nix;
  };
in
modules
