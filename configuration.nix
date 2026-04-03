{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/nixos/boot.nix
    ./modules/nixos/desktop.nix
    ./modules/nixos/hardware.nix
    ./modules/nixos/packages.nix
    ./modules/nixos/system.nix
  ];

  networking.hostName = "icarus";
  system.stateVersion = "25.05";

}
