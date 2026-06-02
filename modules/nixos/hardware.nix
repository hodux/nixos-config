{ config, pkgs, ... }:

{
  hardware.uinput.enable = true;

  # Firmware & Power
  services.fwupd.enable = true;

  # Keyd (Keyboard remapping)
  services.keyd.enable = true;
  services.keyd.keyboards.default.settings.main.capslock = "overload(control, esc)";
}
