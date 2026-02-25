{ pkgs, ... }:

{
  # fixes some of the icons for Arashi
  xdg.desktopEntries = {
    "org.kde.kate" = {
      name = "Kate";
      genericName = "Text Editor";
      exec = "kate -b %U";
      terminal = false;
      categories = [
        "Utility"
        "TextEditor"
      ];
      mimeType = [ "text/plain" ];
      icon = "org.kde.Kate";
    };

    "jetbrains-idea" = {
      name = "IntelliJ IDEA";
      genericName = "IDE";
      exec = "idea %f";
      terminal = false;
      categories = [
        "Development"
        "IDE"
      ];
      icon = "intelij";
    };

    zen-beta = {
      name = "Zen Browser";
      genericName = "Web Browser";
      exec = "zen-beta %u";
      terminal = false;
      categories = [
        "Network"
        "WebBrowser"
      ];
      mimeType = [
        "text/html"
        "text/xml"
        "application/xhtml+xml"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
      ];
      icon = "zen";
    };

    obsidian = {
      name = "Obsidian";
      genericName = "Knowledge Base";
      exec = "obsidian %u";
      terminal = false;
      categories = [ "Office" ];
      mimeType = [ "x-scheme-handler/obsidian" ];
      icon = "md.obsidian.Obsidian";
    };
  };

  home.pointerCursor = {
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    size = 32;
    gtk.enable = true;
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Arashi";
      package = pkgs.arashi;
    };

    theme = {
      name = "Orchis-Light";
      package = pkgs.orchis-theme;
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
