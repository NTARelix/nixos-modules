{ pkgs, ... }:
let
  sf-cli = pkgs.stdenv.mkDerivation {
    pname = "sf-cli";
    version = "2.136.8";
    src = pkgs.fetchurl {
      url = "https://github.com/salesforcecli/cli/releases/download/2.153.4/sf-v2.153.4-4238885-linux-x64.tar.gz";
      hash = "sha256-Oiq6A+VvkvcQ8QLlJDIOSFei1EtME/hsdb46CQ0Htdc=";
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
