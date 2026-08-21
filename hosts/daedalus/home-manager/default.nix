{ config, ... }:

{
  imports = [
    ./niri.nix
  ];
  home.file.".config/noctalia".source = 
    config.lib.file.mkOutOfStoreSymlink "/home/rintaro/projects/nixos-config/home/noctalia/daedalus";
  # home.file.".config/winapps".source = 
  #   config.lib.file.mkOutOfStoreSymlink "/home/rintaro/nixos-config/home/winapps";

}
