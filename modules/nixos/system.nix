{ config, pkgs, ... }:

{
  # Networking
  networking.networkmanager.enable = true;
  time.timeZone = "America/Toronto";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # User Account
  users.users.rintaro = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "libvirtd"
      "kvm"
    ];
    shell = pkgs.fish;
  };

  # Nix Settings (Flakes, Garbage Collection, etc)
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.download-buffer-size = 67108864;
  nixpkgs.config.allowUnfree = true;

  # Core Programs
  programs.fish.enable = true;
  programs.nix-ld.enable = true;
  # programs.nix-ld.libraries = with pkgs; [
  #   # Add any missing dynamic libraries for unpackaged programs
  #   # here, NOT in environment.systemPackages
  # ];
  documentation.man.generateCaches = false;

  # Swap
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 4 * 1024;
    }
  ];
  zramSwap.enable = true;
}
