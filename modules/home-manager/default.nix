{
  config,
  pkgs,
  inputs,
  system,
  ...
}:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
    inputs.zen-browser.homeModules.beta
    inputs.noctalia.homeModules.default
    ./desktop.nix
  ];

  home.username = "rintaro";
  home.homeDirectory = "/home/rintaro";

  # dotfiles
  home.file.".config/fastfetch".source = 
    config.lib.file.mkOutOfStoreSymlink "/home/rintaro/nixos-config/.config/fastfetch";
  home.file.".config/fish".source = 
    config.lib.file.mkOutOfStoreSymlink "/home/rintaro/nixos-config/.config/fish";
  home.file.".config/kitty".source = 
    config.lib.file.mkOutOfStoreSymlink "/home/rintaro/nixos-config/.config/kitty";
  home.file.".config/niri/config.kdl".source = 
    config.lib.file.mkOutOfStoreSymlink "/home/rintaro/nixos-config/.config/niri/config.kdl";
  home.file.".config/nvim".source = 
    config.lib.file.mkOutOfStoreSymlink "/home/rintaro/nixos-config/.config/nvim";
  home.file.".config/tmux".source = 
    config.lib.file.mkOutOfStoreSymlink "/home/rintaro/nixos-config/.config/tmux";
  home.file.".config/vicinae".source = 
    config.lib.file.mkOutOfStoreSymlink "/home/rintaro/nixos-config/.config/vicinae";

  programs.noctalia = {
    enable = true;
    settings = {
      # configure noctalia here
    };
    # this may also be a string or a path to a JSON file.
  };
  programs.zen-browser.enable = true;
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle # shuffle+ (special characters are sanitized out of extension names)
    ];
    # theme = spicePkgs.themes.catppuccin;
    # colorScheme = "mocha";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "zen-beta";
      "x-scheme-handler/http" = "zen-beta";
      "x-scheme-handler/https" = "zen-beta";
      "x-scheme-handler/about" = "zen-beta";
      "x-scheme-handler/unknown" = "zen-beta";
      "application/xhtml+xml" = "zen-beta";

      "image/jpeg" = "org.pwmt.zathura.desktop";
      "image/png" = "org.pwmt.zathura.desktop";
      "image/gif" = "org.pwmt.zathura.desktop";
      "image/webp" = "org.pwmt.zathura.desktop";
      "image/svg+xml" = "org.pwmt.zathura.desktop";
      "image/bmp" = "org.pwmt.zathura.desktop";
      "image/tiff" = "org.pwmt.zathura.desktop";

      "application/pdf" = "org.pwmt.zathura.desktop";
      "application/epub+zip" = "org.pwmt.zathura.desktop";
      "application/postscript" = "org.pwmt.zathura.desktop";

      "inode/directory" = "thunar.desktop";

      "text/plain" = "org.kde.kate.desktop";
      "text/markdown" = "org.kde.kate.desktop";
      "application/json" = "org.kde.kate.desktop";
      "application/x-shellscript" = "org.kde.kate.desktop";
      "text/x-c" = "org.kde.kate.desktop";
      "text/x-c++" = "org.kde.kate.desktop";
      "text/x-python" = "org.kde.kate.desktop";
      "text/rust" = "org.kde.kate.desktop";
      "text/xml" = "org.kde.kate.desktop";
      "application/xml" = "org.kde.kate.desktop";

      "video/mp4" = "vlc.desktop";
      "video/x-matroska" = "vlc.desktop";
      "video/webm" = "vlc.desktop";
      "audio/mpeg" = "vlc.desktop";
      "audio/flac" = "vlc.desktop";
      "audio/x-wav" = "vlc.desktop";

      "application/zip" = "xarchiver.desktop";
      "application/x-tar" = "xarchiver.desktop";
      "application/x-bzip2" = "xarchiver.desktop";
      "application/x-gzip" = "xarchiver.desktop";
      "application/x-xz" = "xarchiver.desktop";
      "application/x-7z-compressed" = "xarchiver.desktop";
      "application/vnd.rar" = "xarchiver.desktop";
    };
  };

  xdg.desktopEntries.trash = {
    name = "Trash";
    genericName = "Trash Can";
    comment = "Open the Trash Can";
    exec = "thunar trash:///"; 
    icon = "user-trash";
    terminal = false;
    categories = [ "System" "Utility" ];
  };
  # don't change this
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
