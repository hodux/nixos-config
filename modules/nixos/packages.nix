{ inputs, config, pkgs, ... }:

{
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  programs.wireshark.enable = true;
  programs.wireshark.dumpcap.enable = true;
  programs.dconf.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    # langs (should be with nix develop)
    nodejs_24
    bun
    go
    lua
    rustc
    cargo
    python3
    gradle
    openjdk25
    openjdk21

    # lsps
    tree-sitter
    jdt-language-server
    pyright
    nixd
    stylua

    # Terminal Emulators
    kitty
    tmux
    sesh

    # Shell
    starship
    eza
    zoxide
    direnv
    fzf
    bat
    yazi
    tldr
    file
    ripgrep
    fd
    jq

    # Core
    git
    gh
    act
    gcc
    gnumake
    cmake
    openssl

    # System & Monitoring
    btop
    lsof
    ddcutil
    wlopm
    brightnessctl
    playerctl
    pavucontrol
    libinput
    gparted
    libqalculate

    # Wayland
    hyprpicker
    hypridle
    wl-clipboard
    wl-mirror
    xwayland-satellite
    glib
    gsettings-desktop-schemas
    gnome-themes-extra
    gtk-engine-murrine
    libnotify
    udiskie
    gvfs
    stow

    # Network & Storage
    curl
    wget
    traceroute
    dig
    sshfs
    smbclient-ng
    p7zip
    unzip
    xarchiver

    # Editors
    vscode
    neovim
    jetbrains.idea

    # Apps
    obsidian
    vesktop
    onlyoffice-desktopeditors
    obs-studio
    vlc
    kdePackages.kate
    gimp
    thunar
    scrcpy
    ffmpeg
    wine
    spotify

    # Infra
    kubectl
    kubelogin-oidc
    kustomize
    talosctl
    opentofu
    vault-bin
    hugo
    mongosh
    yamllint
    jinja2-cli
    dialog

    # AI
    lmstudio

    # rice
    fastfetch
    cmatrix
    ansilove
    unipicker

  ];
}
