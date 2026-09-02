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
	services.sunshine = {
    		enable = true;
    		autoStart = true;
    		capSysAdmin = true; # only needed for Wayland -- omit this when using with Xorg
    		openFirewall = true;
  	};
	environment.systemPackages = with pkgs; [ 
		gamescope
		gamescope-wsi
	];

}
