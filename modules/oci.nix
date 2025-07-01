{ pkgs, ... }:
{
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [ docker-compose ];
  users.users.nixos.extraGroups = [ "docker" ];
}

