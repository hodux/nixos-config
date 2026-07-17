{ config, pkgs, ... }:

{
  hardware.uinput.enable = true;
  hardware.i2c.enable = true;

  # Firmware & Power
  services.fwupd.enable = true;
}
