{ pkgs, ...}:
{

	dconf.settings = {
		"org/gnome/shell" = {
			favorite-apps = [
			"zen-beta.desktop"
    			"org.gnome.Nautilus.desktop"
    			"kitty.desktop"
    			"steam.desktop"
    			"org.qbittorrent.qBittorrent.desktop"
    			"com.github.johnfactotum.Foliate.desktop"
    			"spotify.desktop"
    			"obsidian.desktop"
    			"codium.desktop"
    			".virt-manager-wrapped.desktop"
			];
			enabled-extensions = [ 
			"space-bar@luchrioh"
			"appindicatorsupport@rgcjonas.gmail.com"
			"paperwm@paperwm.github.com"
			"caffeine@patapon.info"
			"blur-my-shell@aunetx"
			"dash-to-dock@micxgx.gmail.com"
			];
			"extensions/paperwm/show-workspace-indicator" = false;
			"extensions/dash-to-dock/hot-keys" = "false";
		};
	};

	home.packages = with pkgs; [
    	 gnomeExtensions.space-bar
	 gnomeExtensions.appindicator
  	 gnomeExtensions.paperwm
	 gnomeExtensions.caffeine
	 gnomeExtensions.blur-my-shell
	 gnomeExtensions.dash-to-dock
	];



}
