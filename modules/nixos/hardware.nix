{ config, pkgs, ... }:

{
  # Graphics (Intel)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ intel-media-driver ];
  };

  # Bluetooth
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

  # Firmware & Power
  services.fwupd.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

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
}
