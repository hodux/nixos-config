{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./modules/nixos/boot.nix
    ./modules/nixos/desktop.nix
    ./modules/nixos/hardware.nix
    ./modules/nixos/packages.nix
    ./modules/nixos/system.nix
    # ./modules/nixos/cybersec.nix
  ];
}
