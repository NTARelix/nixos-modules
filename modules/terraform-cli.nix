{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    terraform
  ];
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "terraform"
    ];
}
