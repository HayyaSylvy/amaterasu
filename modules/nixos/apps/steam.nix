{ pkgs, ...}:
{
	# Basic setup to enable Steam, Gamemode and Gamescope.
	programs.gamemode = {
		enable = true;
		enableRenice = true;
	};
        programs.gamescope = {
		enable = true;
	};
	programs.steam = {
		enable = true;
		protontricks.enable = true;
		package = pkgs.steam;
		extraPackages = with pkgs; [
			gamescope
			gamescope-wsi
			mangohud
            		gamemode
		];
		extraCompatPackages = with pkgs; [ proton-ge-bin ];
	};
	jovian.steam.enable = true;
	jovian.decky-loader = {
		enable = true;
		user = "ladyhayya";
		plugins = with pkgs.decky-plugins; [
		protondb_badges
		css_loader
		steamgriddb
		];
	};
	environment.systemPackages = with pkgs; [ 
		gamescope
		gamescope-wsi
	];

}
