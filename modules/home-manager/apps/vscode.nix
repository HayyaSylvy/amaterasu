{ pkgs, ... }:
{
	programs.vscodium = {
		enable = true;
		package = pkgs.vscodium;
		profiles."Akari" = {
		extensions = with pkgs.nix-vscode-extensions.open-vsx; [ 
			yandeu.five-server
			ms-python.python
			bbenoist.nix
			danielpinto8zz6.c-cpp-compile-run
		 
		 	pkgs.nix-vscode-extensions.vscode-marketplace.liemlb.nix-flakes
		];
		  userSettings = {
			"terminal.integrated.fontFamily" = "MesloLGS NF";
			"clangd.path" = "clangd";
			"clangd.semanticHighlighting" = "true";
			"cmake.configureOnOpen" = "false";
			"cmake.buildDirectory" = "{workspaceFolder}";
			"cmake.generator" = "Ninja";
			"clang-format.executable" = "clang-format";
			"clang-format.style" = "llvm";
			"editor.suggest.insertMode" = "replace";
			"window.titleBarStyle" = "custom";
			"git.confirmSync" = "false";
			"editor.inlayHints.enabled" = "false";
		  };
		};
	};

	#
	stylix.targets.vscodium = {
		profileNames = [ "Akari" ];
		enable = true;
	};

}
