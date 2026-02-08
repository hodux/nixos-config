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
    ./modules/home-manager
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

  # Packages that should be installed to the user profile.
  home.packages = [
    pkgs.openjdk17-bootstrap
  ];

  home.file.".jdks/openjdk-17-eclipse".source = pkgs.openjdk17-bootstrap;

  # don't change this
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
