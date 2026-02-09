{ pkgs, ...}:
{
	# Installs and manages Retroarch and all of its cores.
	programs.retroarch = {
		enable = true;
		cores = {
			mgba.enable = true;
			desmume.enable = true;
			citra.enable = true;
		};
	};
	# Installs Ryubing (Ryujinx fork).
	home.packages = [ 
		pkgs.ryubing 
	];

}
