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

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.ananicy.enable = true;
  programs.gamemode.enable = true;

  hardware.wooting.enable = true;
  # services.displayManager.ly = {
  #   settings = {
  #     # animation
  #     animate = true;
  #     animation = "doom";
  #     # dur_file_path = "/home/rintaro/nixos-config/hosts/blackhole-smooth-240x67.dur";
  #
  #     # F1–F12 hints
  #     hide_key_hints = true;
  #     # version
  #     hide_version_string = true;
  #
  #     # clock above login prompt
  #     bigclock = true;
  #     vi_mode = true;
  #   };
  # };
}
