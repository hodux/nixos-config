{ inputs, config, pkgs, ... }:

{
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  programs.wireshark.enable = true;
  programs.wireshark.dumpcap.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    # Terminal Emulators
    kitty

    # Dev + CLIs
    git
    gh
    lazygit
    tmux
    ripgrep
    fd
    adoptopenjdk-icedtea-web
    openjdk21
    kubectl
    kubelogin-oidc
    krew
    nodejs_24
    bun
    go
    lua
    rustc
    cargo
    python3
    yamllint
    fastfetch
    cmatrix
    btop
    openssl
    sshfs
    unzip
    gcc
    gnumake
    gvfs
    smbclient-ng
    aichat
    gemini-cli-bin
    antigravity
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
    tree-sitter
    nil
    lazygit
    fzf
    act
    bat
    vicinae
    freerdp
    kustomize
    curl
    wget
    jq
    sesh
    vault-bin
    jinja2-cli
    lmstudio
    _7zip-zstd
    yazi
    scrcpy
    ffmpeg
    dialog
    libnotify
    # inputs.niri-scratchpad.packages.${pkgs.system}.default
    jdt-language-server
    jdk21
    gradle
    pyright

    # cybersec
    netcat
    gobuster
    ffuf
    nmap
    sqlmap
    whatweb
    burpsuite
    postman
    jwt-hack
    gtfocli
    hashcat
    # sage
    cyberchef
    steghide
    exiftool
    audacity
    binwalk
    pwntools
    strace
    ghidra
    gdb
    gef
    tldr
    gnuradio
    bloodhound
    chisel
    responder
    metasploit
    thc-hydra
    wireguard-tools
    wireshark
    zsteg
    termshark

    # Editors
    neovim
    vscode
    jetbrains.idea
    jetbrains.rider

    # System
    hyprpicker
    hypridle
    wl-clipboard
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
    udiskie
    gparted
    libqalculate

    # Apps
    obsidian
    vesktop
    spotify-player
    onlyoffice-desktopeditors
    obs-studio
    vlc
    kdePackages.kate
    kdePackages.kolourpaint
    kstars
    zathura
    qutebrowser
    inkscape
    gimp
    thunar
    motrix-next
    waynergy
    wl-mirror
    xarchiver
  ];
}
