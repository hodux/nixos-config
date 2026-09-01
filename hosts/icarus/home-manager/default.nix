{ config, ... }:

{
  imports = [
    ./niri.nix
  ];
  home.file.".config/noctalia".source = 
    config.lib.file.mkOutOfStoreSymlink "/home/rintaro/projects/nixos-config/home/noctalia/icarus";
}
