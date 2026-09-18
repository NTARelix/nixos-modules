{ pkgs, ... }:
let
  unstablePkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/e554fab72f81915600f3f449b786fd9af40439a5.tar.gz";
  }) { };
in
{
  environment.systemPackages = [ unstablePkgs.datadog-pup ];
}
