{ pkgs, ... }:
{
	#
	programs.vscode = {
		enable = true;
		package = pkgs.vscodium;
		profiles."Akari" = {
		  extensions = with pkgs.nix-vscode-extensions.open-vsx; [
			io-github-oops418.nix-env-picker
			jnoortheen.nix-ide
			yandeu.five-server
			ms-python.python
		  ];
		  userSettings = {
			"nixEnvSelector.useFlakes" = true;
			"terminal.integrated.fontFamily" = "MesloLGS NF";
			"nixEnvPicker.terminalAutoActivate" = true;
			"nixEnvPicker.terminalActivateCommand" = "nix develop";
		  };
		};
	};

	#
	stylix.targets.vscode = {
		profileNames = [ "Akari" ];
		enable = true;
	};

}
