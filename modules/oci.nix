# The primary Open Container Image runtime: Docker (https://www.docker.com/).
# Configured directly in this file with NixOS.
# Run in any shell with `docker` for simple Docker commands.
# Or `docker-compose` for managing stacks of containers.
{ pkgs, ... }:
let
  # Under WSL2 mirrored networking, Docker jumps to its DNAT chain from nat/PREROUTING with
  # no loopback exclusion — unlike its nat/OUTPUT rule, which carries `! -d 127.0.0.0/8`.
  # Connections from the Windows host arrive via PREROUTING, get rewritten into the bridge
  # network, and the reply cannot return over the mirrored loopback, so Windows clients
  # (DBeaver, browsers) time out on every published port. Returning early for loopback
  # destinations lets the connection terminate on docker-proxy instead, which is reachable.
  # Delete-then-insert keeps the rule at position 1 and idempotent, since Docker re-adds its
  # own jump whenever the daemon restarts.
  loopback-dnat-bypass = pkgs.writeShellScript "docker-loopback-dnat-bypass" ''
    ${pkgs.iptables}/bin/iptables -t nat -D PREROUTING -d 127.0.0.0/8 -j RETURN 2>/dev/null || true
    ${pkgs.iptables}/bin/iptables -t nat -I PREROUTING 1 -d 127.0.0.0/8 -j RETURN
  '';
in
{
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [ docker-compose ];
  users.users.nixos.extraGroups = [ "docker" ];

  systemd.services.docker-loopback-dnat-bypass = {
    description = "Skip Docker DNAT for loopback so the Windows host can reach published ports";
    after = [ "docker.service" ];
    partOf = [ "docker.service" ];
    wantedBy = [ "multi-user.target" "docker.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${loopback-dnat-bypass}";
      ExecStop = "${pkgs.iptables}/bin/iptables -t nat -D PREROUTING -d 127.0.0.0/8 -j RETURN";
    };
  };
}
