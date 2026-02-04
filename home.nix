{
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

  home.username = "rintaro";
  home.homeDirectory = "/home/rintaro";

  programs.noctalia-shell = {
    enable = true;
    settings = {
      # configure noctalia here
    };
    # this may also be a string or a path to a JSON file.
  };

  programs.zen-browser.enable = true;
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

      # theme = spicePkgs.themes.comfy;
      # colorScheme = "Mono";
    };

  home.pointerCursor = {
    name = "WhiteSur-cursors";
    package = pkgs.whitesur-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "WhiteSur";
      package = pkgs.whitesur-icon-theme;
    };

    theme = {
      name = "WhiteSur-Light";
      package = pkgs.whitesur-gtk-theme;
    };

    font = {
      name = "Inter";
    };

  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  # Zen as default browser
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

  # Packages that should be installed to the user profile.
  home.packages = [
  ];

  # don't change this
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
