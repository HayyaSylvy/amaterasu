{ config, pkgs, lib, inputs, ... }:
{

  # Enables WPaperD, a wallpaper Daemon that uses the Stylix wallpaper in any WM. Pretty useful :P
  services.wpaperd.enable = true;

  programs.dank-material-shell = {
   enable = true;
   dgop.package = pkgs.dgop;
   settings = {
        #currentThemeName = "custom";
	#customThemeFile = "/home/ladyhayya/.config/GruvboxRose.json"; # Uses the theme file generated above.
	screenPreferences = { 
		"wallpaper" = "[]";        # Uses the wallpaper provided by WPaperD instead of it's built-in wallpaper engine.
        };
	disableBuitInWallpaper = true;
	dockTransparency = lib.mkForce 0.9;
  	dankLauncherV2Size = "compact";
	dankLauncherV2ShowFooter =  false;
	blurWallpaperOnOverview = true;
	weatherLocation = "João Pessoa, Região Nordeste"; # My city :3
	weatherCoordinates = "-7.1215981,-34.8820280"; # My cities coordinates :P
	launcherLogoMode = "os"; # So it uses a Nix logo.
	# ----- Setting up the Dock ----
	showDock = true;
	dockGroupByApp = true;
	dockOpenOnOverview = true;
	dockAutoHide = true;
	dockIndicatorStyle = "line";
	dockBorderEnabled = true;
	dockBorderColor = "primary";
	dockPosition = 1;
	dockSpacing = 10;
	dockBottomGap = -20;
	dockMargin = 0;
	dockIconSize = 50;
	dockBorderOpacity = 1;
	dockBorderThickness = 2;
	# -----------------------------
	qtThemingEnabled = false;
	gtkThemingEnabled = false;
	managePluginSettings = true;
	powerActionConfirm = false;
  	barConfigs = [
	  {
		id = "default";
		name = "Main Bar";
		"enabled" = true;
		position = 0;
		screenPreferences = [
		"all"
		];
		showOnLastDisplay = true;
      		"leftWidgets" = [
        		"launcherButton"
        		"workspaceSwitcher"
        		"focusedWindow"
      		];
      		"centerWidgets" = [
        		"music"
        		"clock"
        		"weather"
      		];
      		"rightWidgets" = [
			{ id = "systemTray"; "enabled" = true; }        			      { id = "dankKDEConnect"; "enabled" = true; }
			{ id = "clipboard"; "enabled" = true; }
        		{ id = "cpuUsage"; "enabled" = true; }
        		{ id = "memUsage"; "enabled" = true; }        
			{ id = "notificationButton"; "enabled" = true; }
			{ id = "battery"; "enabled" = true; }
			{ id = "controlCenterButton"; "enabled" = true;}
			{ id = "controlPanel"; enabled = true; }
      		];
	  }
      ];
   };
   plugins = { 
	dankKDEConnect = { 
		enable = true;
		settings = { 
			enable = true; 
		};
		src = inputs.dms-plugin-registry.packages.${pkgs.system}.dankKDEConnect;
	};
   };
   niri = {
      enableSpawn = true;      # Auto-start DMS with niri
      includes.enable = false;
   };
   enableDynamicTheming = false;  # Disables Matugen, which is useless with Stylix.
   };

}
