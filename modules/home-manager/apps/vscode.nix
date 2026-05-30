{ pkgs, ... }:
{
	#
	programs.vscodium = {
		enable = true;
		package = pkgs.vscodium;
		profiles."Akari" = {
		extensions = with pkgs.nix-vscode-extensions.open-vsx; [ 
			catppuccin.catppuccin-vsc
			yandeu.five-server
			ms-python.python
			bbenoist.nix
		 	pkgs.nix-vscode-extensions.vscode-marketplace.liemlb.nix-flakes
		];
		userSettings = {
			"terminal.integrated.fontFamily" = "MesloLGS NF";
			"workbench.colorTheme" = "Catppuccin Mocha";
			"window.titleBarStyle" = "custom";
		  };
		};
	};

	#
	stylix.targets.vscode = {
		profileNames = [ "Akari" ];
		enable = true;
	};

}
