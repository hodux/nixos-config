{ config, ... }:

{
  home.file.".config/noctalia".source = 
    config.lib.file.mkOutOfStoreSymlink "/home/rintaro/nixos-config/.config/noctalia/icarus";
  home.file.".config/niri/monitors.kdl".text = ''
    output "eDP-1" {
      mode "1920x1080@60"
      scale 1
      transform "normal"
      position x=0 y=0
    }
  '';
}
