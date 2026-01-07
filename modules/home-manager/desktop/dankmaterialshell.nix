{ config, pkgs, ... }:
{
  # Manually generates a theme for DankMaterialShell, now with Stylix :D
  xdg.configFile."GruvboxRose.json".text = ''
    {
    "dark": {
    	"name": "Gruvbox-Rose Dark",
    	"primary": "${config.lib.stylix.colors.withHashtag.base0D}",
    	"primaryText": "${config.lib.stylix.colors.withHashtag.base01}",
    	"primaryContainer": "${config.lib.stylix.colors.withHashtag.base0B}",
    	"secondary": "${config.lib.stylix.colors.withHashtag.base0B}",
    	"surface": "${config.lib.stylix.colors.withHashtag.base01}",
    	"surfaceText": "${config.lib.stylix.colors.withHashtag.base07}",
    	"surfaceVariant": "${config.lib.stylix.colors.withHashtag.base00}",
    	"surfaceVariantText": "${config.lib.stylix.colors.withHashtag.base04}",
    	"surfaceTint": "${config.lib.stylix.colors.withHashtag.base0B}",
    	"background": "${config.lib.stylix.colors.withHashtag.base01}",
    	"backgroundText": "${config.lib.stylix.colors.withHashtag.base07}",
    	"outline": "${config.lib.stylix.colors.withHashtag.base03}",
    	"surfaceContainer": "${config.lib.stylix.colors.withHashtag.base00}",
    	"surfaceContainerHigh": "${config.lib.stylix.colors.withHashtag.base01}",
    	"surfaceContainerHighest": "${config.lib.stylix.colors.withHashtag.base02}",
    	"error": "${config.lib.stylix.colors.withHashtag.base0D}",
    	"warning": "${config.lib.stylix.colors.withHashtag.base08}",
    	"info": "${config.lib.stylix.colors.withHashtag.base0A}",
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
   dgop.package = pkgs.dgop;
   settings = {
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
      includes.enable = false;
    };
   enableDynamicTheming = false;  # Disables Matugen, which is useless with Stylix.
   };

}
