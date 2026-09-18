{ lib, pkgs, ... }:
let
  playwright-cli = pkgs.buildNpmPackage rec {
    pname = "playwright-cli";
    version = "0.1.19";

    src = pkgs.fetchFromGitHub {
      owner = "microsoft";
      repo = "playwright-cli";
      tag = "v${version}";
      hash = "sha256-pbv51ybubbjoIpKg0k7lfXfZ9Z+qdZI2lRhQeI+/mFA=";
    };

    npmDepsHash = "sha256-aY3i+sc2p8iQAEpfs+j/ifeBVmMpDDmwctEqOIDmCqI=";

    dontNpmBuild = true;

    nativeBuildInputs = [ pkgs.makeWrapper ];

    postInstall =
      let
        browserLibPath = lib.makeLibraryPath (
          with pkgs;
          [
            alsa-lib
            at-spi2-atk
            atk
            cairo
            cups
            dbus
            expat
            glib
            gobject-introspection
            libgbm
            libxkbcommon
            nspr
            nss
            pango
            stdenv.cc.cc.lib
            systemd
            libx11
            libxcomposite
            libxdamage
            libxext
            libxfixes
            libxrandr
            libxcb
            libGL
            vulkan-loader
          ]
        );
      in
      ''
        wrapProgram $out/bin/playwright-cli \
          --suffix NIX_LD_LIBRARY_PATH : "${browserLibPath}" \
          --suffix LD_LIBRARY_PATH : "${browserLibPath}"
      '';

    meta = {
      changelog = "https://github.com/microsoft/playwright-cli/releases/tag/v${version}";
      description = "Token-efficient CLI + agent skills for driving a browser with Playwright, an alternative to playwright-mcp";
      homepage = "https://github.com/microsoft/playwright-cli";
      license = lib.licenses.asl20;
      mainProgram = "playwright-cli";
    };
  };
in
{
  environment.systemPackages = [ playwright-cli ];
}
