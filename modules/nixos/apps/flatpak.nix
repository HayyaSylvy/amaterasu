{ lib, ... }: 
{
   # Legacy module I used to install Flatpaks
   # Most of these were just moved to Nixpkgs versions for convienency.
   services.flatpak = {
        enable = true;
        update.onActivation = true;
        remotes = [ 
	{ name = "flathub"; location = "https://flathub.org/repo/flathub.flatpakrepo"; }
	#{ name = "amethyst"; location = "https://chrisdkn.github.io/Amethyst-Mod-Manager/amethyst.flatpakref"; }
	];
        packages = [ 
	"org.onlyoffice.desktopeditors"
	"com.usebottles.bottles"
	"org.gimp.GIMP"
	#{ appId = "io.github.Amethyst.ModManager"; origin = "amethyst"; }
	];
   };

}
