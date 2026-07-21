{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
  ];

  networking.hostName = "icarus";
  system.stateVersion = "25.05";

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ intel-media-driver ];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
        ControllerMode = "bredr";
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  # Keyd (Keyboard remapping)
  services.keyd.enable = true;
  services.keyd.keyboards.default.settings.main.capslock = "overload(control, esc)";

  # Keyd Fix for Touchpad
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Keyd Virtual Keyboard]
    MatchName=keyd virtual keyboard
    MatchUdevType=keyboard
    AttrKeyboardIntegration=internal
  '';

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  # services.displayManager.ly = {
  #   settings = {
  #     # animation
  #     animate = true;
  #     animation = "colormix";
  #
  #     # F1–F12 hints
  #     hide_key_hints = true;
  #     # version
  #     hide_version_string = true;
  #
  #     # clock above login prompt
  #     bigclock = true;
  #
  #     vi_mode = true;
  #     battery_id = "BAT0";
  #   };
  # };



}
