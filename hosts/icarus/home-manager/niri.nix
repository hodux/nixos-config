{ config, ... }:

{
  home.file.".config/niri/monitors.kdl".text = ''
    output "eDP-1" {
      mode "1920x1080@60"
      scale 1
      transform "normal"
      position x=0 y=1080
    }

    output "DP-1" {
      mode "1920x1080@60"
      scale 1
      transform "normal"
      position x=330 y=0
      // position x=1920 y=0
    }
  '';
}
