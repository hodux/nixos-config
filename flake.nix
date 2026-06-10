{
  description = "niri + noctalia multi-host NixOS with home-manager for dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri-scratchpad.url = "github:argosnothing/niri-scratchpad";

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };

  nixConfig = {
    extra-substituters = [ "https://cache.garnix.io" ];
    extra-trusted-public-keys = [ "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" ];
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      mkHomeManager = hostHomeFile: {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users.rintaro = {
          imports = [
            ./modules/home-manager
            hostHomeFile
          ];
        };
      };
    in
    {
      nixosConfigurations = {
        
        # laptop
        icarus = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/icarus
            ./configuration.nix
            home-manager.nixosModules.home-manager
            (mkHomeManager ./hosts/icarus/home-manager)
          ];
        };

        # desktop
        daedalus = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/daedalus
            ./configuration.nix
            home-manager.nixosModules.home-manager
            (mkHomeManager ./hosts/daedalus/home-manager)

            {
              nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.default ];
            }
          ];
        };

      };
    };
}
