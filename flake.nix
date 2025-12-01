{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/25.11";
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
    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dgop.follows = "dgop";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, home-manager, nix-flatpak, stylix, nixvim, dgop, dankMaterialShell, ... }: {
    
    nixosConfigurations = {
      amaterasu = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # Imports essential system-related configurations
          ./hosts/amaterasu/configuration.nix
          ./hosts/amaterasu/hardware-configuration.nix
          # Imports Nix related-modules
          home-manager.nixosModules.home-manager
          nix-flatpak.nixosModules.nix-flatpak
          stylix.nixosModules.stylix
          inputs.niri.nixosModules.niri
          # Imports other system-related modules
          ./modules/nixos/flatpak.nix
          # Setups Home Manager for "Lady Hayya" (AKA: this cute girl here :3)
          {
            home-manager = { 
               useGlobalPkgs = true;
               useUserPackages = true;
               users.ladyhayya = { 
                  imports = [ 
                    ./hosts/amaterasu/home.nix
                    nixvim.homeModules.nixvim
                    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
                    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
                  ];
               };
            };
          }
        ];
      };
    };

  };
}
