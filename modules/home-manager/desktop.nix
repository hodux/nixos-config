{ config, pkgs, inputs, ... }:

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
      name = "Colloid";
      package = pkgs.colloid-icon-theme;
    };
    gtk4.theme = null;
    colorScheme = "light";
    theme = {
      name = "Yaru-blue";
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

}
