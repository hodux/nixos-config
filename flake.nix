{
  description = "niri + noctalia multi-host NixOS with home-manager for dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
    # winapps = {
    #   url = "github:winapps-org/winapps";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    sysc-greet = {
      url = "github:Nomadcxx/sysc-greet";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-substituters = [ 
      "https://attic.xuyh0120.win/lantian" 
      "https://cache.xinux.uz"
      "https://noctalia.cachix.org"
    ];
    extra-trusted-public-keys = [ 
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" 
      "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      mkHomeManager = system: hostHomeFile: {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs system; };
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
            (mkHomeManager "x86_64-linux" ./hosts/icarus/home-manager)
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
            (mkHomeManager "x86_64-linux" ./hosts/daedalus/home-manager)

            {
              nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.default ];
            }
          ];
        };
      };
    };
}
