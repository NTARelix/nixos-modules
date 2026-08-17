{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    claude-code
    mcp-language-server
    mcp-nixos
    pi-coding-agent
    playwright-mcp
    sox
    terraform-mcp-server
  ];
}
