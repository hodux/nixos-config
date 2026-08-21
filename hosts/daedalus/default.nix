{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.nixpkgs-xr.nixosModules.nixpkgs-xr
    ./hardware-configuration.nix
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

  services.lact.enable = true;
  services.wivrn.enable = true;
  services.wivrn.openFirewall = true;
  programs.weylus.enable = true;
  programs.weylus.openFirewall = true;
  environment.systemPackages = with pkgs; [
    prismlauncher
    wootility
    # cisco-packet-tracer_9
    protonup-qt
    wayvr
    xrizer
    lutris
    parsec-bin
    ananicy-cpp
    ananicy-rules-cachyos
    davinci-resolve
    vmpk
    alsa-utils
    blockbench
    packwiz
  ];
}
