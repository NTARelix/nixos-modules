{
    description = "A collection of reusable NixOS modules";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    outputs = { nixpkgs, ... }: {
        editor = import ./modules/editor.nix;
        git = import ./modules/git.nix;
        shell = import ./modules/shell.nix;
    };
}

