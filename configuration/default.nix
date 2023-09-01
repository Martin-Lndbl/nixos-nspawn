{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
  ];

  networking.useNetworkd = true;
  networking.useHostResolvConf = false;

  services.getty.autologinUser = "root";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  networking.hostName = "testc";
  system.stateVersion = "23.05";
}
