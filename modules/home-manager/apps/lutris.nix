{ pkgs, config, ...}:
{

	programs.lutris = {
		enable = true;
		winePackages = [ pkgs.winePackages.waylandFull ];
	};


}
