# nixos-nspawn [WIP]

Fast and simple way to create a systemd-nspawn container from a flake.

## Benefits
* Host and Container share a nix store, thereby improving performance and size.
* Standalone container don't require system rebuilds on change

## Usage
* Install & Start: `sudo install-container [containername]` starts a container in the shell. If no entry for `containername` is found at `/var/lib/machines/` a new container is created instead. machinectl may be used on running containers, but needs extra configuration to be able to start the container.
* Update: Updating the config can be done from within the container. Rerunning the `install-container`-script also works but needs the container to be shut down.
* Destroy: `sudo destroy-container [containername]` stops and removes the container as well as its entries in `/nix/var/nix/profiles` and `/nix/var/nix/gcroots`

## Configuration
* Edit the `install-container`-script to fit your needs.
* Add the following to your nixos config to use machinectl to start the container:
```nix
{ pkgs, ... }:

let containerName = "template";
in
{
  systemd.nspawn."${containerName}" = {
    execConfig = {
      Boot = false;
      Parameters = "/nix/var/nix/profiles/system/init";
    };
    filesConfig = {
      BindReadOnly = [
        "/nix/store"
        "/nix/var/nix/db"
        "/nix/var/nix/daemon-socket"
      ];
      Bind = [
        "/nix/var/nix/profiles/per-container/${containerName}:/nix/var/nix/profiles"
        "/nix/var/nix/gcroots/per-container/${containerName}:/nix/var/nix/gcroots"
      ];
    };
    networkConfig = {
        Private = true;
    };
  };
}
```

## Note
This is not the most "Nix-way" to deploy containers but helpful for testing.
