{
  # Manually generates a theme for DankMaterialShell, it doesn't use Stylix unfortunatly :(
  xdg.configFile."GruvboxRose.json".text = ''
    {
    "dark": {
    	"name": "Gruvbox-Rose Dark",
    	"primary": "#fb4934",
    	"primaryText": "#1b1b1b",
    	"primaryContainer": "#98971A",
    	"secondary": "#98971A",
    	"surface": "#1b1b1b",
    	"surfaceText": "#FBF1C7",
    	"surfaceVariant": "#282828",
    	"surfaceVariantText": "#928374",
    	"surfaceTint": "#98971A",
    	"background": "#1b1b1b",
    	"backgroundText": "#FBF1C7",
    	"outline": "#928374",
    	"surfaceContainer": "#282828",
    	"surfaceContainerHigh": "#3C3836",
    	"surfaceContainerHighest": "#504945",
    	"error": "#FB4934",
    	"warning": "#FABD2F",
    	"info": "#83A598",
    	"matugen_type": "scheme-expressive"
  	},
    "light": {
    	"name": "Gruvbox-Rose Light",
    	"primary": "#EA6962",
    	"primaryText": "#FBF1C7",
    	"primaryContainer": "#98971A",
    	"secondary": "#98971A",
    	"surface": "#FBF1C7",
    	"surfaceText": "#1b1b1b",
    	"surfaceVariant": "#EBDBB2",
    	"surfaceVariantText": "#928374",
    	"surfaceTint": "#98971A",
    	"background": "#FBF1C7",
    	"backgroundText": "#1b1b1b",
    	"outline": "#928374",
    	"surfaceContainer": "#EBDBB2",
    	"surfaceContainerHigh": "#D5C4A1",
    	"surfaceContainerHighest": "#BDAE93",
    	"error": "#CC241D",
    	"warning": "#D79921",
    	"info": "#458588",
    	"matugen_type": "scheme-expressive"
  	}
       }
  '';

  # Enables WPaperD, a wallpaper Daemon that uses the Stylix wallpaper in any WM. Pretty useful :P
  services.wpaperd.enable = true;

  programs.dankMaterialShell = {
   enable = true;
   default.settings = {
        currentThemeName = "custom";
	customThemeFile = "/home/ladyhayya/.config/GruvboxRose.json"; # Uses the theme file generated above.
	screenPreferences = { 
		"wallpaper" = "[]";        # Uses the wallpaper provided by WPaperD instead of it's built-in wallpaper engine.
        };
	dockTransparency = 0.9;
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
	powerActionConfirm = false;
   };
    niri = {
      enableSpawn = true;      # Auto-start DMS with niri
    };
   enableDynamicTheming = false;  # Disables Matugen, which is useless with Stylix.

};
