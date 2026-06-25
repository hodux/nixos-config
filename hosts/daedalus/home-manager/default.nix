{ config, ... }:

{
  home.file.".config/noctalia".source = 
    config.lib.file.mkOutOfStoreSymlink "/home/rintaro/nixos-config/.config/noctalia/daedalus";
  home.file.".config/winapps".source = 
    config.lib.file.mkOutOfStoreSymlink "/home/rintaro/nixos-config/.config/winapps";
  home.file.".config/niri/monitors.kdl".text = ''
    output "DP-1" {
        mode "3440x1440@143.975"
        scale 1
        transform "normal"
        position x=0 y=1080
    }

    output "DP-3" {
        mode "1920x1080@60"
        scale 1
        transform "normal"
        position x=750 y=0
    }
  '';

}
