{
  description = "Container template";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-23.05";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ (import ./overlays) ];
        };
      in
      {
        overlays.default = import ./overlays;

        nixosConfigurations.template = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration
            ({ pkgs, config, ... }: {
              boot.isContainer = true;
              boot.loader.initScript.enable = true;
            })
          ] ++ import ./modules;
        };
      }
    );
}
