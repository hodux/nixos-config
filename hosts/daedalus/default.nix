{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
  ];

  networking.hostName = "daedalus";
  system.stateVersion = "25.05";
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

  hardware.amdgpu.initrd.enable = true;
  hardware.enableAllFirmware = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.amdgpu.overdrive.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.ananicy.enable = true;
  programs.gamemode.enable = true;
  hardware.wooting.enable = true;
  powerManagement.cpuFreqGovernor = "performance";
}
