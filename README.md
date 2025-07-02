# NixOS Modules Flake

A collection of configuration modules for [NixOS] in the form of a [flake].

## Install

1. Have root access in [NixOS] (works in [WSL])

2. (optional) Clone this repo into `/etc/` if you intend on modifying it:

    ```bash
    git clone git@github.com:NTARelix/nixos-modules-flake /etc/nixos-modules-flake
    ```

3. Configure your main NixOS configuration to enable flakes:

    ```diff
      # /etc/nixos/configuration.nix
      { pkgs, ... }:
      {
    +     environment.systemPackages = with pkgs; [ git ];
    +     nix.settings.experimental-features = [ "nix-command" "flakes" ];
          imports = [ ./hardware-configuration.nix ];
          boot.loader.systemd-boot.enable = true;
          networking.hostName = "my-nixos";
          system.stateVersion = "25.05";
      }
    ```

4. Rebuild NixOS to enable flakes:

    ```bash
    sudo nixos-rebuild switch
    ```

5. Create the new default configuration file:

    ```nix
    # /etc/nixos/flake.nix
    {
        description = "My NixOS flake.";
        inputs = {
            nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
            # change the following path to wherever you cloned this repo
            shared-modules.url = "path:/etc/nixos-modules-flake";
            # or use this line instead if you didn't clone the repo in step #2
            # shared-modules.url = "github:NTARelix/nixos-modules-flake/master";
        };
        outputs = { self, nixpkgs, shared-modules ... }@inputs: {
            # replace my-nixos with your hostname
            nixosConfigurations.my-nixos = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    # import previous config so it still takes effect
                    ./configuration.nix
                    # Uncomment the modules below that you want.
                    # Each module has a corresponding file in ./modules.
                    # You can find each module's docs in their file.
                    # shared-modules.editor
                    # shared-modules.git
                    # shared-modules.shell
                    # shared-modules.oci
                ];
            };
        };
    }
    ```

6. Rebuild NixOS with the new flake configuration:

    ```bash
    sudo nixos-rebuild switch
    ```

## Updating flakes

If you cloned this repo and made changes to any of the modules then you'll need to rebuild nixos.

NOTE: I've found that I also need to update the flakes, but I haven't confirmed when exactly that step is necessary.

```bash
cd /etc/nixos/
sudo nix flake update && sudo nixos-rebuild switch
```

### WSL

NixOS in WSL seems to require the `--impure` flag when rebuilding NixOS.

```bash
cd /etc/nixos
sudo nix flake update && sudo nixos-rebuild switch --impure
```

[Flakes]: https://wiki.nixos.org/wiki/Flakes
[NixOS]: https://nixos.org/
[WSL]: https://learn.microsoft.com/en-us/windows/wsl/

