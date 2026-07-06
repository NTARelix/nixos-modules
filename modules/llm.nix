{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    claude-code
    pi-coding-agent
  ];
}
