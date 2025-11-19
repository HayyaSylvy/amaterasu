{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/25.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    stylix = { 
        url = "github:nix-community/stylix";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
        url = "github:nix-community/nixvim";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, home-manager, nix-flatpak, stylix, ... }: {
    
    nixosConfigurations = {
      akhetaten = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # Imports essential system-related configurations
          ./hosts/akhetaten/configuration.nix
          ./hosts/akhetaten/hardware-configuration.nix
          # Imports Nix related-modules
          home-manager.nixosModules.home-manager
          nix-flatpak.nixosModules.nix-flatpak
          #nixvim.nixosModules.nixvim
          stylix.nixosModules.stylix
          # Imports other system-related modules
          ./modules/nixos/flatpak.nix
          # Setups Home Manager for "Lady Hayya" (AKA: this cute girl here :3)
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ladyhayya = ./hosts/akhetaten/home.nix;
          }
        ];
      };
    };

  };
}
