{ lib, ... }: 
{
   # Legacy module I used to install Flatpaks
   # Most of these were just moved to Nixpkgs versions for convienency.
   services.flatpak = {
        enable = true;
        update.onActivation = true;
        remotes = [ 
	{ name = "flathub"; location = "https://flathub.org/repo/flathub.flatpakrepo"; }
	];
        packages = [ 
	"org.onlyoffice.desktopeditors"
	"org.gimp.GIMP"
	"com.pokemmo.PokeMMO"
	{flatpakref = "https://chrisdkn.github.io/Amethyst-Mod-Manager/amethyst.flatpakref";sha256 = "1iwzky2nbd0wp4ydmcbh1ap1rzfa7kr55qfsq9wvm3w3i8bsjqih";}	
	];
   };

}
