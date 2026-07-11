{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Display Manager
  # services.displayManager.gdm.enable = true;

  imports = [
    inputs.sysc-greet.nixosModules.default
  ];

  # https://codeberg.org/fairyglade/ly/src/branch/master/src/config/Config.zig
  # config in individual hosts
  # services.displayManager.ly.enable = true;
  services.sysc-greet = {
    enable = true;
    compositor = "niri";  # or "hyprland" or "sway"
  };

  # authentication agent for gparted
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
    };
  };

  systemd.user.services.waynergy = {
    description = "waynergy-client";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.waynergy}/bin/waynergy -c 10.0.0.57 --enable-crypto --enable-tofu -b uinput";
      Restart = "on-failure";
      RestartSec = 5;
    };
};

  # Window Managers
  programs.niri = {
    enable = true;
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
    meslo-lg
    nerd-fonts.meslo-lg
    nerd-fonts.geist-mono
    nerd-fonts.meslo-lg
  ];
}
