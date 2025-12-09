{ pkgs, ... }:
{
	#
	programs.vscode = {
		enable = true;
		package = pkgs.vscodium;
		profiles."Akari" = {
		  extensions = with pkgs.nix-vscode-extensions.open-vsx; [
			arrterian.nix-env-selector
			ms-ceintl.vscode-language-pack-pt-br
			yandeu.five-server
		  ];
		  userSettings = {
			locale = "pt-br"; 
		  };
		};
	};

	#
	stylix.targets.vscode = {
		profileNames = [ "Akari" ];
		enable = true;
	};

}
