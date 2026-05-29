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
			jnoortheen.nix-ide
			ms-python.python
		  ];
		  userSettings = {
			"terminal.integrated.fontFamily" = "MesloLGS NF";
			"workbench.colorTheme" = "Catppuccin Mocha";
		  };
		};
	};

	#
	stylix.targets.vscode = {
		profileNames = [ "Akari" ];
		enable = true;
	};

}
