{ config, pkgs, ... }:

{
  # Networking
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 1701 ];
  };
  time.timeZone = "America/Toronto";

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [ pkgs.gutenprint ];
  };

  # User Account
  users.groups.uinput = { };
  users.users.rintaro = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "libvirtd"
      "kvm"
      "uinput"
    ];
    shell = pkgs.fish;
  };

  # Nix Settings (Flakes, Garbage Collection, etc)
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.download-buffer-size = 134217728;
  nixpkgs.config.allowUnfree = true;

  # Core Programs
  programs.fish.enable = true;
  programs.nix-ld.enable = true;
  # programs.nix-ld.libraries = with pkgs; [
  #   # Add any missing dynamic libraries for unpackaged programs
  #   # here, NOT in environment.systemPackages
  # ];
  documentation.man.cache.enable = false;
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  # Swap
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 4 * 1024;
    }
  ];
  zramSwap.enable = true;
}
