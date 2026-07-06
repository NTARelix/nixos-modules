{ pkgs, ... }:
let
  sf-cli = pkgs.stdenv.mkDerivation {
    pname = "sf-cli";
    version = "2.136.8";
    src = pkgs.fetchurl {
      url = "https://github.com/salesforcecli/cli/releases/download/2.142.1/sf-v2.142.1-e403f1c-linux-x64.tar.xz";
      hash = "sha256-YYahc3/GJ3Y9ubZESM/SPWt3I2B9zSwGfHs5K68YuEY=";
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
