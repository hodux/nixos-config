{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Networking
  networking.networkmanager.enable = true;
  time.timeZone = "America/Toronto";

  # networking.wg-quick.interfaces = {
  #   user07 = {
  #     configFile = "/etc/wireguard/user07.conf";
  #   };
  # };

  services.udisks2.enable = true;
  # Optional: if you want it to show up specifically in /media instead of /run/media
  services.udisks2.mountOnMedia = true;
  services.envfs.enable = true;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [ pkgs.gutenprint ];
  };

  # User Account
  users.users.rintaro = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "libvirtd"
      "kvm"
      "uinput"
      "input"
      "wireshark"
      "i2c"
    ];
    shell = pkgs.fish;
  };

  # Nix Settings (Flakes, Garbage Collection, etc)
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.download-buffer-size = 524288000;
  nixpkgs.config.allowUnfree = true;

  # Core Programs
  programs.fish.enable = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    stdenv.cc.cc.lib
    stdenv.cc
    zlib
    fuse3
    icu
    nss
    openssl
    curl
    expat
  ];

  documentation.man.cache.enable = false;

  # Swap
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 4 * 1024;
    }
  ];
  zramSwap.enable = true;

  environment.systemPackages = [
    inputs.winapps.packages."${pkgs.stdenv.hostPlatform.system}".winapps
    inputs.winapps.packages."${pkgs.stdenv.hostPlatform.system}".winapps-launcher # optional
  ];

}
