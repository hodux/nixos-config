{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
  ];

  networking.hostName = "daedalus";
  system.stateVersion = "25.05";
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
  boot.kernelModules = [ "snd-virmidi" ];

  hardware.amdgpu.initrd.enable = true;
  hardware.enableAllFirmware = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };
  hardware.amdgpu.overdrive.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  programs.gamemode.enable = true;
  hardware.wooting.enable = true;
  powerManagement.cpuFreqGovernor = "performance";
}
