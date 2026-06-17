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

  programs.noctalia-shell = {
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
      coverAmbience
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
      "image/jpeg" = "org.pwmt.zathura.desktop";
      "image/png" = "org.pwmt.zathura.desktop";
      "inode/directory" = "thunar.desktop";
    };
  };

  # don't change this
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
