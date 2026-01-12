{
  description = "icarus Laptop NixOS configuration";

  inputs = {
    # Unstable package set
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Spotify 1.2.63.394.g126b0d89
    # spotify.url = "github:nixos/nixpkgs/0d59e0290eefe0f12512043842d7096c4070f30e";

    # Spicetify
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    # Zen Browser
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
    };

    # Caelestia
    # caelestia-shell = {
    #   url = "github:caelestia-dots/shell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    #
    # caelestia-cli = {
    #   url = "github:caelestia-dots/cli";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        icarus = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              # Pass arguments to ./home.nix
              home-manager.extraSpecialArgs = {
                inherit inputs;
              };

              home-manager.users.rintaro = ./home.nix;

            }
          ];
        };
      };
    };
}
