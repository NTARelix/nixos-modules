{ lib, pkgs, ... }:
let
  unstable-pkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/34ca302a9572963c02e385c056be37c85ff51b77.tar.gz";
  }) { config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "claude-code" ]; };
in
{
  environment.systemPackages = with pkgs; [
    unstable-pkgs.claude-code
    mcp-language-server
    mcp-nixos
    pi-coding-agent
    playwright-mcp
    sox
    terraform-mcp-server
  ];
}
