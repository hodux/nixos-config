{ pkgs, ... }:

{
  home.pointerCursor = {
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    size = 16;
    gtk.enable = true;
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "kora";
      package = pkgs.kora-icon-theme;
    };

    gtk4.theme = null;
    theme = {
      name = "Yaru-dark";
      package = pkgs.yaru-theme;
    };

    font = {
      name = "Inter";
    };

  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

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

}
