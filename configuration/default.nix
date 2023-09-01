{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    hello
  ];

  networking.useNetworkd = true;
  networking.useHostResolvConf = false;

  services.getty.autologinUser = "root";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  networking.hostName = "template";
  system.stateVersion = "23.05";
}
