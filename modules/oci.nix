# The primary Open Container Image runtime: Docker (https://www.docker.com/).
# Configured directly in this file with NixOS.
# Run in any shell with `docker` for simple Docker commands.
# Or `docker-compose` for managing stacks of containers.
{ pkgs, ... }:
{
    virtualisation.docker.enable = true;
    environment.systemPackages = with pkgs; [ docker-compose ];
    users.users.nixos.extraGroups = [ "docker" ];
}

