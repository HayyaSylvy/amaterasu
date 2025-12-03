{ config, pkgs, lib, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ladyhayya";
  home.homeDirectory = "/home/ladyhayya";
  
  xdg.userDirs = {
      enable = true;
      createDirectories = true;
  };

  home.language.base = "pt-BR.UTF-8";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05";

  # The home.packages option allows you to install Nix packages.
  home.packages = with pkgs; [
     hyfetch
     fastfetch
     meslo-lgs-nf
  ];
   
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


  programs.nixvim.enable = true;
  services.wpaperd.enable = true;
  programs.dankMaterialShell = {
   enable = true;
   default.settings = {
        currentThemeName = "custom";
	customThemeFile = "/home/ladyhayya/.config/GruvboxRose.json";
	screenPreferences = { 
		"wallpaper" = "[]";        
        };
	dockTransparency = 0.9;
	blurWallpaperOnOverview = true;
	weatherLocation = "João Pessoa, Região Nordeste";
	weatherCoordinates = "-7.1215981,-34.8820280";
	launcherLogoMode = "os";
	showDock = true;
	dockGroupByApp = true;
	dockOpenOnOverview = true;
	dockAutoHide = true;
	dockIndicatorStyle = "line";
	dockBorderEnabled = true;
	dockBorderColor = "primary";
	powerActionConfirm = false;
	dockPosition = 1;
	dockSpacing = 10;
	dockBottomGap = -20;
	dockMargin = 0;
	dockIconSize = 50;
	dockBorderOpacity = 1;
	dockBorderThickness = 2;
	qtThemingEnabled = false;
	gtkThemingEnabled = false;
   };
    niri = {
      enableSpawn = true;      # Auto-start DMS with niri
    };
   enableDynamicTheming = false;  
  };
  programs.niri.settings = {
       # Setups the correct scale for my Monitors
       outputs."eDP-1".scale = 1.25;
       outputs."eDP-2".scale = 1.25;
       # Setups the keyboard to Br-ABNT
       input.keyboard.xkb.layout = "br";
       # Setups Gestures
       gestures = {
         dnd-edge-view-scroll = {
            trigger-width = 30;
            delay-ms = 100;
            max-speed = 1500;
         };
         dnd-edge-workspace-switch = {
           trigger-height = 50;
           delay-ms = 100;
           max-speed = 1500;
         };
       };
       layout = {
          gaps = 5;
	  preset-column-widths = [
            { proportion = 1. / 3.; }
            { proportion = 1. / 2.; }
            { proportion = 2. / 3.; }
          ];
          default-column-width.proportion = 0.5;
       };
       overview.workspace-shadow.enable = false;
       environment = {
         XDG_CURRENT_DESKTOP = "niri";
         QT_QPA_PLATFORM = "wayland";
         ELECTRON_OZONE_PLATFORM_HINT = "auto";
         QT_QPA_PLATFORMTHEME = "qt5ct";
         TERMINAL = "kitty";
       };
       hotkey-overlay.skip-at-startup = true;
       prefer-no-csd = true;
       animations = {
        enable = true;
        workspace-switch = {
          enable = true;
          kind.spring = { 
	    damping-ratio=0.80;
	    stiffness=523; 
	    epsilon=0.0001;
	  };
        };
        window-open = {
          enable = true;
	  kind.easing = {
            duration-ms = 150;
            curve = "ease-out-expo";
	  };
        };
        window-close = {
          enable = true;
	  kind.easing = {
            duration-ms = 150;
            curve = "ease-out-quad";
	  };
        };
        horizontal-view-movement = {
          enable = true;
          kind.spring = {
	    damping-ratio=0.85; 
	    stiffness=423;
	    epsilon=0.0001;
	  };
        };
        window-movement = {
          enable = true;
          kind.spring = {
	   damping-ratio=0.75;
	   stiffness=323;
	   epsilon=0.0001;
	  };
        };
        window-resize = {
          enable = true;
	  kind.spring = {
	   damping-ratio=0.85; 
	   stiffness=423; 
	   epsilon=0.0001;
	  };
        };
        config-notification-open-close = {
          enable = true;
          kind.spring = {
	   damping-ratio=0.65; 
	   stiffness=923; 
	   epsilon=0.001;
	  };
        };
        screenshot-ui-open = {
          enable = true;
	  kind.easing = {
           duration-ms = 200;
           curve = "ease-out-quad";
	  };
        };
        overview-open-close = {
	  enable = true;
          kind.spring = {
	    damping-ratio=0.85; 
	    stiffness=800;
	    epsilon=0.0001;
          };
        };
       };
       # Window Rules
       window-rules = [
           # Rules for Kitty Terminal
	   {
             matches = [{ app-id = "^kitty$"; }];
              draw-border-with-background = false;
           }
           # Makes inactive apps transparent 
	   {
             matches = [{ is-active=false; }];
             opacity = 0.9;
           }
	   {
             geometry-corner-radius.bottom-left = 12.001;
             geometry-corner-radius.bottom-right = 12.001;
             geometry-corner-radius.top-left = 12.001;
             geometry-corner-radius.top-right = 12.001;
             clip-to-geometry = true;
           }
	   {
             matches = [{app-id = "floorp$"; title="^Picture-in-Picture$";}];
             open-floating = true;
           }
           {
             matches = [{app-id="^steam$";}];
             open-floating = true;
           }
	   {
	     matches = [{app-id="^xdg-desktop-portal$";}];
	     open-floating = true;
	   }
       ];
       binds = {
         # Window navegation shortcuts
         "Mod+Q" = { 
	   action.spawn = [ "niri" "msg" "action" "close-window" ];
	   repeat = false;
	 };
         "Mod+F".action.spawn = [ "niri" "msg" "action" "maximize-column" ];
         "Mod+Shift+F".action.spawn = [ "niri" "msg" "action" "fullscreen-window" ];
         "Mod+Shift+T".action.spawn = [ "niri" "msg" "action" "toggle-window-floating" ] ;
         "Mod+Shift+V".action.spawn = [ "niri" "msg" "action" "switch-focus-between-floating-and-tiling" ];
         "Mod+W".action.spawn = [ "niri" "msg" "action" "toggle-column-tabbed-display" ];
         # Focus Navigation
    	 "Mod+Left".action.spawn = [ "niri" "msg" "action" "focus-column-left" ];
    	 "Mod+Down".action.spawn = [ "niri" "msg" "action" "focus-window-down" ];
  	 "Mod+Up".action.spawn =   [ "niri" "msg" "action" "focus-window-up" ];
    	 "Mod+Right".action.spawn = [ "niri" "msg" "action" "focus-column-right" ];
    	 "Mod+H".action.spawn =    [ "niri" "msg" "action" "focus-column-left" ];
    	 "Mod+J".action.spawn =    [ "niri" "msg" "action" "focus-window-down" ];
    	 "Mod+K".action.spawn =    [ "niri" "msg" "action" "focus-window-up" ];
    	 "Mod+L".action.spawn = [ "niri" "msg" "action" "focus-column-right" ];
         #=== Window Movement ===
         "Mod+Shift+Left".action.spawn = ["niri" "msg" "action" "move-column-left" ];
         "Mod+Shift+Down".action.spawn = ["niri" "msg" "action" "move-window-down" ];
         "Mod+Shift+Up".action.spawn = ["niri" "msg" "action" "move-window-up" ];
         "Mod+Shift+Right".action.spawn = ["niri" "msg" "action" "move-column-right" ];
         "Mod+Shift+H".action.spawn = ["niri" "msg" "action" "move-column-left" ];
         "Mod+Shift+J".action.spawn = ["niri" "msg" "action" "move-window-down" ];
         "Mod+Shift+K".action.spawn = ["niri" "msg" "action" "move-window-up" ];
         "Mod+Shift+L".action.spawn = ["niri" "msg" "action" "move-column-right" ];
         # Column Navigation ===
         "Mod+Home".action.spawn = ["niri" "msg" "action" "focus-column-first" ];
         "Mod+End".action.spawn = ["niri" "msg" "action" "focus-column-last" ];
         "Mod+Ctrl+Home".action.spawn = [ "niri" "msg" "action" "move-column-to-first" ];
         "Mod+Ctrl+End".action.spawn =  [ "niri" "msg" "action" "move-column-to-last" ];
         # Workspace Navigation
         "Mod+Page_Down".action.spawn = [ "niri" "msg" "action" "focus-workspace-down" ];
         "Mod+Page_Up".action.spawn = [ "niri" "msg" "action" "focus-workspace-up" ];
         "Mod+U".action.spawn = ["niri" "msg" "action" "focus-workspace-down" ];
         "Mod+I".action.spawn = ["niri" "msg" "action" "focus-workspace-up" ];
         "Mod+Ctrl+Down".action.spawn = ["niri" "msg" "action" "move-column-to-workspace-down" ];
         "Mod+Ctrl+Up".action.spawn = ["niri" "msg" "action" "move-column-to-workspace-up" ];
         "Mod+Ctrl+U".action.spawn = ["niri" "msg" "action" "move-column-to-workspace-down" ];
         "Mod+Ctrl+I".action.spawn = ["niri" "msg" "action" "move-column-to-workspace-up" ];
         "Mod+Shift+Page_Down".action.spawn = ["niri" "msg" "action" "move-workspace-down" ];
         "Mod+Shift+Page_Up".action.spawn = [ "niri" "msg" "action" "move-workspace-up" ];
         "Mod+Shift+U".action.spawn = [ "niri" "msg" "action" "move-workspace-down" ];
         "Mod+Shift+I".action.spawn = [ "niri" "msg" "action" "move-workspace-up" ];
         # Numbered Workspaces
         "Mod+1".action.spawn = [ "niri" "msg" "action" "focus-workspace" "1" ];
         "Mod+2".action.spawn = [ "niri" "msg" "action"  "focus-workspace" "2" ];
         "Mod+3".action.spawn  = [  "niri" "msg" "action" "focus-workspace" "3" ];
         "Mod+4".action.spawn  = [  "niri" "msg" "action" "focus-workspace" "4" ];
         "Mod+5".action.spawn  = [ "niri" "msg" "action" "focus-workspace" "5" ];
         "Mod+6".action.spawn  = [  "niri" "msg" "action" "focus-workspace" "6" ];
         "Mod+7".action.spawn  = [  "niri" "msg" "action" "focus-workspace" "7" ];
         "Mod+8".action.spawn  = [  "niri" "msg" "action" "focus-workspace" "8" ];
         "Mod+9".action.spawn = [  "niri" "msg" "action" "focus-workspace" "9" ];
          # Move to Numbered Workspaces
         "Mod+Shift+1".action.spawn = [ "niri" "msg" "action" "move-column-to-workspace" "1" ];
         "Mod+Shift+2".action.spawn = [ "niri" "msg" "action" "move-column-to-workspace" "2" ];
         "Mod+Shift+3".action.spawn = [ "niri" "msg" "action" "move-column-to-workspace" "3" ];
         "Mod+Shift+4".action.spawn = [ "niri" "msg" "action" "move-column-to-workspace" "4" ];
         "Mod+Shift+5".action.spawn = [ "niri" "msg" "action" "move-column-to-workspace" "5" ];
         "Mod+Shift+6".action.spawn = [ "niri" "msg" "action" "move-column-to-workspace" "6" ];
         "Mod+Shift+7".action.spawn = [ "niri" "msg" "action" "move-column-to-workspace" "7" ];
         "Mod+Shift+8".action.spawn = [ "niri" "msg" "action" "move-column-to-workspace" "8" ];
         "Mod+Shift+9".action.spawn = [ "niri" "msg" "action" "move-column-to-workspace" "9" ];
	 # Column Management ===
         "Mod+BracketLeft".action.spawn = ["niri" "msg" "action" "consume-or-expel-window-left" ];
         "Mod+BracketRight".action.spawn = ["niri" "msg" "action" "consume-or-expel-window-right" ];
         "Mod+Period".action.spawn = ["niri" "msg" "action"  "expel-window-from-column" ];

         # Sizing & Layout
         "Mod+R".action.spawn = [ "niri" "msg" "action"  "switch-preset-column-width" ];
	 "Mod+Shift+R".action.spawn = [ "niri" "msg" "action"  "switch-preset-window-height" ];
    	 "Mod+Ctrl+R".action.spawn = [ "niri" "msg" "action"  "reset-window-height" ];
    	 "Mod+Ctrl+F".action.spawn = [ "niri" "msg" "action"  "expand-column-to-available-width" ];
    	 "Mod+C".action.spawn = [  "niri" "msg" "action" "center-column" ];
    	 "Mod+Ctrl+C".action.spawn = [  "niri" "msg" "action" "center-visible-columns" ];

    	 # Manual Sizing
    	 "Mod+Minus".action.spawn = [ "niri" "msg" "action" "set-column-width" "-10%" ];
    	 "Mod+Equal".action.spawn = [ "niri" "msg" "action" "set-column-width" "+10%" ];
    	 "Mod+Shift+Minus".action.spawn = [  "niri" "msg" "action" "set-window-height" "-10%" ];
    	 "Mod+Shift+Equal".action.spawn = [ "niri" "msg" "action" "set-window-height" "+10%" ];
    	 # Screenshots
    	 "XF86Launch1".action.spawn = ["niri" "msg" "action"  "screenshot" ];
    	 "Ctrl+XF86Launch1".action.spawn = ["niri" "msg" "action"  "screenshot-screen" ];
    	 "Alt+XF86Launch1".action.spawn = ["niri" "msg" "action"  "screenshot-window" ];
    	 "Print".action.spawn = ["niri" "msg" "action" "screenshot" ];
    	 "Ctrl+Print".action.spawn = ["niri" "msg" "action" "screenshot-screen" ];
    	 "Alt+Print".action.spawn = ["niri" "msg" "action" "screenshot-window" ];
	 
	 # App-launching shortcuts
         "Mod+T".action.spawn = "kitty";
	 "Mod+D".action.spawn = ["dms" "ipc" "call" "spotlight" "toggle"];
	 "Mod+V".action.spawn = ["dms" "ipc" "call" "clipboard" "toggle"];
	 "Mod+N".action.spawn = ["dms" "ipc" "call" "notifications" "toggle"];
         "Mod+Shift+N".action.spawn = ["dms" "ipc" "call" "notepad" "toggle"];
         # Niri Overview shortcut
	 "Mod+Space".action.spawn = ["niri" "msg" "action" "toggle-overview"];
         # Lockscreen and Exit Niri shortcuts
	 "Mod+Alt+L".action.spawn = ["dms" "ipc" "call" "lock" "lock"];
	 "Mod+Shift+E".action.quit.skip-confirmation = false;
	 "Mod+Shift+P".action.spawn = ["niri" "msg" "action" "power-off-monitors"  ];
         "Mod+Escape" = {
	   allow-inhibiting = false; 
	   action.spawn = ["niri" "msg" "action" "toggle-keyboard-shortcuts-inhibit" ];
	 };
         # Mouse Wheel Navigation ===
    	"Mod+WheelScrollDown" = {      
	   cooldown-ms=150; 
	   action.spawn = ["niri" "msg" "action" "focus-workspace-down" ];
	};
    	"Mod+WheelScrollUp" = {        
	   cooldown-ms=150;
	   action.spawn = ["niri" "msg" "action" "focus-workspace-up" ];
	};
    	"Mod+Ctrl+WheelScrollDown" = { 
	   cooldown-ms=150;
	   action.spawn = ["niri" "msg" "action" "move-column-to-workspace-down" ];
    	};
	"Mod+Ctrl+WheelScrollUp" = {  
	   cooldown-ms=150; 
	   action.spawn = ["niri" "msg" "action" "move-column-to-workspace-up" ];
	};
    	"Mod+WheelScrollRight".action.spawn = [ "niri" "msg" "action" "focus-column-right" ];
    	"Mod+WheelScrollLeft".action.spawn = ["niri" "msg" "action"  "focus-column-left" ];
    	"Mod+Ctrl+WheelScrollRight".action.spawn = ["niri" "msg" "action" "move-column-right" ];
    	"Mod+Ctrl+WheelScrollLeft".action.spawn =  ["niri" "msg" "action"  "move-column-left" ];
    	"Mod+Shift+WheelScrollDown".action.spawn = ["niri" "msg" "action" "focus-column-right" ];
    	"Mod+Shift+WheelScrollUp".action.spawn = ["niri" "msg" "action" "focus-column-left" ];
    	"Mod+Ctrl+Shift+WheelScrollDown".action.spawn = ["niri" "msg" "action"  "move-column-right" ];
    	"Mod+Ctrl+Shift+WheelScrollUp".action.spawn = ["niri" "msg" "action" "move-column-left" ];
	# Brightness and Volume control keys
	"XF86AudioRaiseVolume" = {
        allow-when-locked = true; 
	action.spawn = ["dms" "ipc" "call" "audio" "increment" "3"];
	};
	"XF86AudioLowerVolume" = {
	   allow-when-locked = true; 
	   action.spawn = ["dms" "ipc" "call" "audio" "decrement" "3"];
	};
	"XF86AudioMute" = {
	   allow-when-locked = true;
	   action.spawn = ["dms" "ipc" "call" "audio" "mute"];
	};
	"XF86AudioMicMute" = {
	allow-when-locked = true; 
	action.spawn = ["dms" "ipc" "call" "audio" "micmute"];
        };
	"XF86MonBrightnessUp" = {
	allow-when-locked = true; 
	action.spawn = ["dms" "ipc" "call" "brightness" "increment" "5"];
        };
	"XF86MonBrightnessDown" = {
	allow-when-locked = true; 
	action.spawn = ["dms" "ipc" "call" "brightness" "decrement" "5"];
        };
      };
  };


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  xdg.configFile."hyfetch.json".text = ''
    {
    "preset": "transgender",
    "mode": "rgb",
    "auto_detect_light_dark": true,
    "light_dark": "dark",
    "lightness": 0.65,
    "color_align": {
        "mode": "horizontal"
    },
    "backend": "fastfetch",
    "args": null,
    "distro": null,
    "pride_month_disable": false,
    "custom_ascii_path": null
    }
  '';

  programs.kitty = { 
    enable = true;
    settings = { 
      tab_bar_min_tabs = 1;
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
    };
    keybindings = {
      "ctrl+T" = "new_tab";
      "alt+shift+1" = "goto_tab 1";
      "alt+shift+2" = "goto_tab 2";
      "alt+shift+3" = "goto_tab 3";
      "alt+shift+4" = "goto_tab 4";
      "alt+shift+5" = "goto_tab 5";
      "alt+shift+6" = "goto_tab 6";
      "alt+shift+7" = "goto_tab 7";
      "alt+shift+8" = "goto_tab 8";
      "alt+shift+9" = "goto_tab 9";
      "alt+shift+0" = "goto_tab 10";
    };
    extraConfig = ''
      background_opacity 0.95
      background_blur 32
    '';
  };

  programs.git = {
     enable = true;
     settings = {
       user.name = "HayyaSylvy";
       user.email = "hannahmarieribeiro@proton.me";
     };
  };
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  stylix.targets.gtk.flatpakSupport.enable = true;
  stylix.enableReleaseChecks = true;
  gtk.iconTheme = {
      name = "Gruvbox-Plus-Dark";
      package = pkgs.gruvbox-plus-icons;
  };

  programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      localVariables = { 
        ZSH_DISABLE_COMPFIX = "true"; # Fixes VSCodium wrong shell warning
      };
      dotDir = "${config.xdg.configHome}/zsh"; 
      oh-my-zsh = {
         enable = true;
         plugins = [ "git" ];
      };
      initContent = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme 
      source ~/.config/zsh/.p10k.zsh
      '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ladyhayya/etc/profile.d/hm-session-vars.sh
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
