{ config, ... }:

{
  imports = [
    ./niri.nix
  ];
  home.file.".config/noctalia".source = 
    config.lib.file.mkOutOfStoreSymlink "/home/rintaro/nixos-config/.config/noctalia/daedalus";
  home.file.".config/winapps".source = 
    config.lib.file.mkOutOfStoreSymlink "/home/rintaro/nixos-config/.config/winapps";
}
