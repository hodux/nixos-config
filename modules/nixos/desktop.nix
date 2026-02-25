{ config, pkgs, ... }:

{
  # Display Manager
  services.displayManager.gdm.enable = true;

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

  # Window Managers
  programs.niri.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # onlyoffice font fix
  system.userActivationScripts = {
    copy-fonts-local-share = {
      text = ''
        rm -rf ~/.local/share/fonts
        mkdir -p ~/.local/share/fonts
        cp ${pkgs.corefonts}/share/fonts/truetype/* ~/.local/share/fonts/
        chmod 544 ~/.local/share/fonts
        chmod 444 ~/.local/share/fonts/*
      '';
    };
  };

  # Fonts
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
    inter
    corefonts
    vista-fonts
  ];
}
