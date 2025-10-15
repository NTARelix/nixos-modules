{ pkgs, ... }:
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
            oldPkgs.azure-cli.extensions.rdbms-connect
        ])
    ];
}

