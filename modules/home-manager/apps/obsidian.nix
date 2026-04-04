{
	programs.obsidian = {
		enable = true;
		vaults = {
			"Estudos.nix" = {
				enable = true;
				target = "./Documents/Obsidian/Estudos.nix";	
			};
			"WrNovel.nix" = {
				enable = true;
				target = "./Documents/Obsidian/WrNovel.nix";
			};
		};
	};
	stylix.targets.obsidian.vaultNames = [
		"Estudos.nix"
		"WrNovel.nix"
	];
}
