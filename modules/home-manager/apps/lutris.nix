{ pkgs, config, osConfig, ...}:
{

	programs.lutris = {
		enable = true;
		protonPackages = [ pkgs.proton-ge-bin ];
		defaultWinePackage = pkgs.proton-ge-bin;
		extraPackages = with pkgs; [
			mangohud
			protontricks
			gamescope
			gamemode
			umu-launcher
		];
		steamPackage = osConfig.programs.steam.package;
	};

}
