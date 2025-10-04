# NixOS Modules

A collection of configuration modules for [NixOS].

## Install

1. Have root access in NixOS (works in [WSL])

2. Clone this repo into `/etc/`:

    ```bash
    git clone git@github.com:NTARelix/nixos-modules /etc/nixos-modules
    ```

3. Import the repo and add the modules that you want to use:

    ```nix
    # /etc/nixos/configuration.nix
    { pkgs, ... }:
    let
        shared-modules = import /etc/nixos-modules;
    in
    {
        imports = [
            # Uncomment the modules below that you want.
            # Each module has a corresponding file in ./modules.
            # You can find each module's docs in their file.
            # shared-modules.editor
            # shared-modules.git
            # shared-modules.shell
            # shared-modules.oci
        ];
    }
    ```

4. Rebuild NixOS with the new configuration:

    ```bash
    sudo nixos-rebuild switch
    ```

[NixOS]: https://nixos.org/
[WSL]: https://learn.microsoft.com/en-us/windows/wsl/

