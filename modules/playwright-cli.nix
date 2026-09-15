# Playwright CLI: a token-efficient CLI + agent-skills alternative to playwright-mcp.
# https://github.com/microsoft/playwright-cli
#
# Not packaged in nixpkgs (as of 2026-09), so it's vendored here with buildNpmPackage,
# in the same shape as nixpkgs' own by-name/pl/playwright-mcp/package.nix.
#
# Unlike playwright-mcp, this CLI pins an exact alpha build of playwright/playwright-core
# (1.63.0-alpha-2026-08-31) that is ahead of nixpkgs' playwright-driver/playwright-test
# (1.61.1), so we can't symlink against nixpkgs' prefetched, pre-patched Chromium the way
# playwright-mcp's package.nix does — the browser revisions wouldn't line up with what this
# playwright-core build expects. Instead `playwright-cli install-browser` downloads its own
# matching browser build at runtime (the normal, non-Nix workflow) into
# $PLAYWRIGHT_BROWSERS_PATH (defaults to ~/.cache/ms-playwright).
#
# Those runtime-downloaded binaries aren't Nix-patched, so on NixOS they fail to find their
# shared libraries (e.g. `chrome: error while loading shared libraries: libglib-2.0.so.0`).
# `nix-ld` (enabled in the host configuration.nix) exists to run exactly this kind of foreign
# binary via NIX_LD_LIBRARY_PATH, and covers actually *launching* the browser. But
# playwright-core's own pre-flight dependency check (run by `install-browser`) shells out to
# `ldd` against the downloaded binaries using plain `LD_LIBRARY_PATH` only (see
# missingFileDependencies in playwright-core's registry/dependencies.ts) — it never looks at
# NIX_LD_LIBRARY_PATH, so that check fails on NixOS unless LD_LIBRARY_PATH is *also* set. We
# suffix both, scoped to this wrapped binary only, using the same library list nixpkgs'
# playwright-driver uses to patch its own bundled Chromium (see
# pkgs/development/web/playwright/driver.nix's chromium buildInputs). Only Chromium's deps are
# covered here — Firefox and WebKit pull in much larger, separate dependency sets (full GTK
# stack, WPE/media libs) that aren't wired up, so stick to `install-browser chromium`.
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

  # Symlink the CLI's bundled agent skill into the user's Claude skills dir, rather than the
  # copy `playwright-cli install --skills` would make. Since the target is interpolated from
  # the derivation, it's always the *current* build's store path — `nixos-rebuild switch`
  # re-runs tmpfiles and repoints the link whenever the package (and its store hash) changes,
  # so nothing goes stale as the system updates.
  systemd.tmpfiles.rules = [
    "L+ /home/nixos/.claude/skills/playwright-cli - - - - ${playwright-cli}/lib/node_modules/@playwright/cli/node_modules/playwright-core/lib/tools/skills/playwright-cli"
  ];
}
