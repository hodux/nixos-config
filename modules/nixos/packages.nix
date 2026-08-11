{ inputs, config, pkgs, ... }:

{
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  programs.wireshark.enable = true;
  programs.wireshark.dumpcap.enable = true;
  programs.dconf.enable = true;
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs; [
    thunar-volman
    thunar-archive-plugin
  ];
  services.tumbler.enable = true;
  programs.xfconf.enable = true;

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
    jdk21

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
    tldr

    # Wayland
    hyprpicker
    hypridle
    wl-clipboard
    wl-mirror
    xwayland-satellite
    glib
    gsettings-desktop-schemas
    gnome-themes-extra
    libnotify
    udiskie
    stow
    # inputs.winapps.packages."${pkgs.stdenv.hostPlatform.system}".winapps
    # inputs.winapps.packages."${pkgs.stdenv.hostPlatform.system}".winapps-launcher # optional
    xeyes

    # Network & Storage
    android-tools
    curl
    wget
    traceroute
    dig
    sshfs
    smbclient-ng
    p7zip
    unzip
    xarchiver
    ngrok

    # Editors
    vscode
    neovim
    # jetbrains.idea

    # Apps
    obsidian
    vesktop
    onlyoffice-desktopeditors
    obs-studio
    vlc
    kdePackages.kate
    gimp
    scrcpy
    ffmpeg
    wine
    zathura
    pureref

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
    opencode
    antigravity-cli

    # rice
    fastfetch
    cmatrix
    ansilove
    unipicker
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-40.10.5"
  ];
}
