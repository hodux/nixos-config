{ config, pkgs, ... }:

{
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  services.dbus.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    # Terminal Emulators
    kitty

    # Dev + CLIs
    git
    tmux
    ripgrep
    fd
    adoptopenjdk-icedtea-web
    python312
    python312Packages.pip
    nodejs_24
    go
    lua
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
    cmake
    hugo
    talosctl
    opentofu

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
    libinput
    glib
    gsettings-desktop-schemas
    gnome-themes-extra
    gtk-engine-murrine
    stow
    matugen
    xwayland-satellite
    wine
    quickemu
    spice-gtk

    # Apps
    obsidian
    vesktop
    onlyoffice-desktopeditors
    obs-studio
    vlc
    kdePackages.kate
    kdePackages.kolourpaint
    kstars
    zathura
    qutebrowser

  ];
}
