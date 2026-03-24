{ pkgs, ... }:
{
	#
	programs.vscode = {
		enable = true;
		package = pkgs.vscodium;
		profiles."Akari" = {
		  extensions = with pkgs.nix-vscode-extensions.open-vsx; [
			yandeu.five-server
			ms-python.python
		  ];
		  userSettings = {
			"terminal.integrated.fontFamily" = "MesloLGS NF";
		  };
		};
	};

	#
	stylix.targets.vscode = {
		profileNames = [ "Akari" ];
		enable = true;
	};

}
