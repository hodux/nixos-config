{ config, ... }:

{
  home.file.".config/noctalia".source = 
    config.lib.file.mkOutOfStoreSymlink "/home/rintaro/nixos-config/.config/noctalia/icarus";
  home.file.".config/niri/monitors.kdl".text = ''
    // Run `niri msg outputs` while inside a niri instance to list all outputs and their modes.
    // mode custom=true "2048x1152@60"

    // Position of the output in the global coordinate space.
    // For example, a 3840×2160 output with scale 2.0 will have a logical size of 1920×1080,
    // so to put another output directly adjacent to it on the right, set its x to 1920.
    // If the position is unset or results in an overlap, the output is instead placed
    // automatically.

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
