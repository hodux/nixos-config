{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    inputs.zen-browser.homeModules.beta
    inputs.noctalia.homeModules.default
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "rintaro";
  home.homeDirectory = "/home/rintaro";

  programs.noctalia-shell = {
    enable = true;
    settings = {
      # configure noctalia here
    };
    # this may also be a string or a path to a JSON file.
  };

  # Zen
  programs.zen-browser.enable = true;

  # Spicetify
  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;

      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle # shuffle+ (special characters are sanitized out of extension names)
      ];
      enabledCustomApps = with spicePkgs.apps; [
        # newReleases
        # ncsVisualizer
      ];
      enabledSnippets = with spicePkgs.snippets; [
        # rotatingCoverart
        # pointer
      ];

      theme = spicePkgs.themes.comfy;
      colorScheme = "Mono";
    };

  # GTK settings
  gtk = {
    enable = true;

    iconTheme = {
      name = "WhiteSur";
      package = pkgs.whitesur-icon-theme;
    };

    # THEME: Controls window colors, buttons, and context menus
    theme = {
      name = "WhiteSur-Dark"; # Options: "WhiteSur-Dark", "WhiteSur-Light"
      package = pkgs.whitesur-gtk-theme;
    };

    # Optional: Font configuration for a cleaner look
    font = {
      name = "Sans";
      size = 11;
    };
  };

  # MOUSE CURSOR (Global System Settings)
  home.pointerCursor = {
    name = "WhiteSur-cursors";
    package = pkgs.whitesur-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # Qt settings
  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  # Default apps
  xdg.mimeApps =
    let
      value =
        let
          zen-browser = zen-browser.packages.nixos.beta; # or twilight
        in
        zen-browser.meta.desktopFileName;

      associations = builtins.listToAttrs (
        map
          (name: {
            inherit name value;
          })
          [
            "application/x-extension-shtml"
            "application/x-extension-xhtml"
            "application/x-extension-html"
            "application/x-extension-xht"
            "application/x-extension-htm"
            "x-scheme-handler/unknown"
            "x-scheme-handler/mailto"
            "x-scheme-handler/chrome"
            "x-scheme-handler/about"
            "x-scheme-handler/https"
            "x-scheme-handler/http"
            "application/xhtml+xml"
            "application/json"
            "text/plain"
            "text/html"
          ]
      );
    in
    {
      associations.added = associations;
      defaultApplications = associations;
    };

  # Enable dconf so runtime changes work
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark"; # Default starting value
    };
  };

  # systemd.user.services.gtk-theme-watcher = {
  #   Unit = {
  #     Description = "Sync GTK theme with Caelestia";
  #     After = [ "graphical-session.target" ];
  #   };
  #
  #   Service = {
  #     # Run the script, wait 3 seconds, repeat.
  #     ExecStart = pkgs.writeShellScript "watch-loop" ''
  #       while true; do
  #         ${pkgs.bash}/bin/bash -c "sync-gtk-mode"
  #         sleep 3
  #       done
  #     '';
  #     Restart = "always";
  #   };
  #
  #   Install = {
  #     WantedBy = [ "graphical-session.target" ];
  #   };
  # };

  # Packages that should be installed to the user profile.
  home.packages = [
    pkgs.openjdk17-bootstrap
    # inputs.caelestia-shell.packages.x86_64-linux.with-cli
    # inputs.caelestia-cli.packages.x86_64-linux.with-shell
    (pkgs.writeShellScriptBin "toggle-theme" ''
      CURRENT_THEME=$(gsettings get org.gnome.desktop.interface gtk-theme)

      if [[ "$CURRENT_THEME" == "'WhiteSur-Dark'" ]]; then
          gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Light'
          gsettings set org.gnome.desktop.interface color-scheme 'default'
      else
          gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Dark'
          gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
      fi
    '')
    # (pkgs.writeShellScriptBin "sync-gtk-mode" ''
    #   # 1. Get what Caelestia wants
    #   TARGET_MODE=$(${inputs.caelestia-cli.packages.x86_64-linux.with-shell}/bin/caelestia scheme get | ${pkgs.gawk}/bin/awk '/Mode:/ {print $2}')
    #   TARGET_MODE="''${TARGET_MODE,,}" # Convert to lowercase (dark/light)
    #
    #   # 2. Get what GTK currently is
    #   CURRENT_GTK=$(${pkgs.glib}/bin/gsettings get org.gnome.desktop.interface gtk-theme)
    #
    #   # 3. Compare and Apply (Only if different)
    #   if [[ "$TARGET_MODE" == "dark" && "$CURRENT_GTK" != "'WhiteSur-Dark'" ]]; then
    #       echo "Switching to Dark Mode..."
    #       ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Dark'
    #       ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    #
    #   elif [[ "$TARGET_MODE" == "light" && "$CURRENT_GTK" != "'WhiteSur-Light'" ]]; then
    #       echo "Switching to Light Mode..."
    #       ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Light'
    #       ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface color-scheme 'default'
    #   fi
    # '')
  ];

  # Create a stable symlink to the JDK's store path
  home.file.".jdks/openjdk-17-eclipse".source = pkgs.openjdk17-bootstrap;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
