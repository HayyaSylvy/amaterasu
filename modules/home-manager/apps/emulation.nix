{ pkgs, ...}:
{
	# Installs and manages Retroarch and all of its cores.
	programs.retroarch = {
		enable = true;
		cores = {
			mgba.enable = true;
			melonds.enable = true;
			citra.enable = true;
		};
	};
	# Installs Ryubing (Ryujinx fork) and Steam Rom Manager
	home.packages = [ 
		pkgs.ryubing 
		pkgs.steam-rom-manager
	];

}
