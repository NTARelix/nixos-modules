{ pkgs, ... }:
let
  sf-cli = pkgs.stdenv.mkDerivation {
    pname = "sf-cli";
    version = "2.136.8";
    src = pkgs.fetchurl {
      url = "https://github.com/salesforcecli/cli/releases/download/2.138.0/sf-v2.138.0-a16ef08-linux-x64.tar.xz";
      hash = "sha256-I0NnzP8nbJVuNqAGYIcRa6spPbs2YyKQvGkc0n3bncg=";
    };
    installPhase = ''
      mkdir -p $out
      cp -r . $out/sf
      mkdir -p $out/bin
      ln -s $out/sf/bin/sf $out/bin/sf
    '';
  };
in
{
  environment.systemPackages = [ sf-cli ];
}
