let
  modules = {
    azure-cli = import ./modules/azure-cli.nix;
    editor = import ./modules/editor.nix;
    git = import ./modules/git.nix;
    llm = import ./modules/llm.nix;
    oci = import ./modules/oci.nix;
    plantuml = import ./modules/plantuml.nix;
    salesforce = import ./modules/salesforce.nix;
    shell = import ./modules/shell.nix;
    terraform-cli = import ./modules/terraform-cli.nix;
  };
in
modules
