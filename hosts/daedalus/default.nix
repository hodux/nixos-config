{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "daedalus";
  system.stateVersion = "25.05";
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

  # AMD GPU Kernel Modules
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "btusb" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  boot.kernelParams = [
    "video=DP-1:3440x1440@60"
    "video=DP-3:1920x1080@60"
  ];

  # Graphics / Mesa / Vulkan Setup
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    
    extraPackages = with pkgs; [ ];
    extraPackages32 = with pkgs; [ ];
  };

  # AMD CPU Specifics
  hardware.cpu.amd.updateMicrocode = true;

  # Desktop Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Crucial for USB Dongles: Includes all common Realtek/Broadcom/Intel firmware
  hardware.enableAllFirmware = true;

  # Optional: Better performance scheduling for Ryzen CPUs
  services.ananicy.enable = true;

  # Enable Steam and performance tuning tools globally
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  programs.gamemode.enable = true;

  services.displayManager.ly = {
    settings = {
      # animation
      animate = true;
      animation = "doom";
      # dur_file_path = "/home/rintaro/nixos-config/hosts/blackhole-smooth-240x67.dur";

      # F1–F12 hints
      hide_key_hints = true;
      # version
      hide_version_string = true;

      # clock above login prompt
      bigclock = true;
      vi_mode = true;
    };
  };

  environment.systemPackages = with pkgs; [
    prismlauncher
    wootility
  ];

}
