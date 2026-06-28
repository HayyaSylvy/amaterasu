{ pkgs, ... }:
{
	programs.vscodium = {
		enable = true;
		package = pkgs.vscodium;
		profiles."Akari" = {
		extensions = with pkgs.nix-vscode-extensions.open-vsx; [ 
			#catppuccin.catppuccin-vsc # Comment this out in case Stylix Vscode breaks.
			yandeu.five-server
			ms-python.python
			bbenoist.nix
		 	pkgs.nix-vscode-extensions.vscode-marketplace.liemlb.nix-flakes
		];
		userSettings = {
			"terminal.integrated.fontFamily" = "MesloLGS NF";
			#"workbench.colorTheme" = "Catppuccin Mocha"; # Same situation as the extension.
			"window.titleBarStyle" = "custom";
			"git.confirmSync" = "false";
		  };
		};
	};

	#
	stylix.targets.vscodium = {
		profileNames = [ "Akari" ];
		enable = true;
	};

	#programs.vscode.enable = true;

}
