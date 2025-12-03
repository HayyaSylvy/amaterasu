{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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

  outputs = inputs@{ self, nixpkgs, home-manager, nix-flatpak, stylix, nixvim, dgop, dankMaterialShell, ... }: {
    
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
	  inputs.dankMaterialShell.nixosModules.greeter
          # Imports other system-related modules
          ./modules/nixos/flatpak.nix
          # Setups Home Manager for "Lady Hayya" (AKA: this cute girl here :3)
          {
            home-manager = { 
               useGlobalPkgs = true;
               useUserPackages = true;
               users.ladyhayya = { 
                  imports = [ 
		    # Imports the Home.nix file. (AKA: the most essential Home Manager file :P)
                    ./hosts/amaterasu/home.nix
		    # Imports the required configurations for Niri (my Tiling Compositor) and DankMaterialShell (the Shell on top of Niri)
		    ./modules/home-manager/desktop/niri.nix
		    ./modules/home-manager/desktop/dankmaterialhshell.nix
		    # Imports some configurations for apps I declare in Home Manager
		    ./modules/home-manager/apps/floorp.nix
		    ./modules/home-manager/apps/kitty.nix # :3
		    ./modules/home-manager/apps/neovim.nix # should be Nixvim instead, idk work the same for me :P
		    # Imports the configuration of my shell and some TUI utilities.
		    ./modules/home-manager/shell/zsh.nix
		    ./modules/home-manager/shell/git.nix
		    # Imports the module that actually make some of the ones listed above work. 
		    # Thank you for the authors, these are pretty incredible and useful :D
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
