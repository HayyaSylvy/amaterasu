{ lib, ... }: 
{
   # Legacy module I used to install Flatpaks
   # Most of these were just moved to Nixpkgs versions for convienency.
   # It still works, I just don't have much of a reason to use it.
   services.flatpak = {
        enable = true;
        update.onActivation = true;
        remotes = [ { name = "flathub"; location = "https://flathub.org/repo/flathub.flatpakrepo"; } ];
        packages = [ 
	"moe.launcher.an-anime-game-launcher"
	"gg.minion.Minion"
	];
   };

}
