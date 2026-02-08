{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/boot.nix
    ./modules/desktop.nix
    ./modules/hardware.nix
    ./modules/packages.nix
    ./modules/system.nix
  ];

  networking.hostName = "icarus";
  system.stateVersion = "25.05";

}
