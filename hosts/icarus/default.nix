{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
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

  environment.systemPackages = with pkgs; [
    webcamoid
  ];
}
