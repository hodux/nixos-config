{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Plymouth
  boot.plymouth.enable = true;
  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "udev.log_priority=3"
    "rd.systemd.show_status=auto"
  ];
  boot.loader.timeout = 0;

  networking.hostName = "icarus";
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Increase buffer to ~64MB (default is often too small)
  nix.settings.download-buffer-size = 67108864;

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 4 * 1024; # 4GB is plenty for general usage
    }
  ];

  # I highly recommend enabling this alongside the small swap file
  zramSwap.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rintaro = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
    ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };

  # https://codeberg.org/fairyglade/ly/src/branch/master/src/config/Config.zig
  # services.displayManager.ly = {
  #   enable = true;
  #
  #   settings = {
  #     # DOOM PSX fire
  #     animate = true;
  #     animation = "0";
  #
  #     # Hide F1–F12 hints
  #     hide_key_hints = true;
  #     # Hide version
  #     hide_version_string = true;
  #
  #     # Add a clock
  #     bigclock = true;
  #   };
  # };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver # For Broadwell+ (2015+)
    intel-vaapi-driver # For older Intel GPUs
  ];

  # Daemon to update firmware UEFI
  services.fwupd.enable = true;

  # Keybindings
  services.keyd.enable = true;
  services.keyd.keyboards.default.settings.main.capslock = "overload(control, esc)";

  # Fix for "disable touchpad while typing not working" caused by keyd
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Keyd Virtual Keyboard]
    MatchName=keyd virtual keyboard
    MatchUdevType=keyboard
    AttrKeyboardIntegration=internal
  '';

  # Allow unfree apps
  nixpkgs.config.allowUnfree = true;

  # NixOS Modules
  programs.fish.enable = true;
  documentation.man.generateCaches = false;
  programs.hyprland.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  services.displayManager.gdm.enable = true;
  programs.dconf.enable = true;
  virtualisation.docker.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    # Terminal Emulators
    kitty
    ghostty

    # Dev + CLIs
    git
    tmux
    ripgrep
    fd
    adoptopenjdk-icedtea-web
    python312
    python312Packages.pip
    nodejs_24
    lua
    go
    kubectl
    krew
    yamllint
    fastfetch
    cmatrix
    btop
    openssl
    unzip
    gcc
    gnumake
    rustc
    cargo
    gvfs
    smbclient-ng
    aichat
    gemini-cli-bin
    starship
    eza
    zoxide
    direnv
    file
    ansilove
    traceroute
    dig
    unipicker
    nixd
    nixfmt
    mongosh
    zellij

    # Editors
    neovim
    vscode
    jetbrains.idea
    zed-editor
    helix

    # System
    hyprshot
    hyprpicker
    hypridle
    wl-clipboard
    thunar
    brightnessctl
    playerctl
    pavucontrol
    home-manager
    whitesur-icon-theme
    libinput
    matugen
    glib
    gsettings-desktop-schemas
    stow

    # Apps
    obsidian
    discord
    onlyoffice-desktopeditors
    obs-studio
    vlc
    kdePackages.kate
    kdePackages.kolourpaint
    kstars

  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts

    # Extra
    font-awesome
    nerd-fonts.jetbrains-mono
    cozette
    source-code-pro
  ];

  # don't change this
  system.stateVersion = "25.05";

}
