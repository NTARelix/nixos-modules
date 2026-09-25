{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ mermaid-cli ];
}
