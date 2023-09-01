# nixos-nspawn [WIP]

Fast and simple way to create a systemd-nspawn container from a flake.
Host and Container will share a nix store, thereby improving performance and size.

## Usage
- Install & Start: `sudo install-container [containername]` will start a container in the shell. If no entry for `containername` is found at `/var/lib/machines/` a new container will be created instead. machinectl may be used on running containers
- Update: Updating the config can be done from within the container. Rerunning the `install-container`-script also works but needs the container to be shut down.
- Destroy: `sudo destroy-container [containername]` will stop and remove the container. 

## Configuration
Edit the 'install-container'-script to fit your needs.

## Note
This is not the most "Nix-way" to deploy containers but helpful for testing.
