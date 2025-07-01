{
    description = "A collection of reusable NixOS modules";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    };
    outputs = { nixpkgs, ... }: {
        editor = import ./modules/editor.nix;
        git = import ./modules/git.nix;
        shell = import ./modules/shell.nix;
    };
}

