{ pkgs, inputs, ...}:
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
		package = pkgs.steam.override {
    		  extraEnv = {
      			LD_AUDIT = "${
        		inputs.sls-steam.packages.${pkgs.stdenv.hostPlatform.system}.sls-steam
      }/library-inject.so:${
        		inputs.sls-steam.packages.${pkgs.stdenv.hostPlatform.system}.sls-steam
      }/SLSsteam.so";
    			};
  		  };
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
