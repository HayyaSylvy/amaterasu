{ config, pkgs, lib, inputs, ... }:
{

  # Enables WPaperD, a wallpaper Daemon that uses the Stylix wallpaper in any WM. Pretty useful :P
  services.wpaperd.enable = true;

  programs.dank-material-shell = {
   enable = true;
   session = {
	pinnedApps = [
    	"zen-beta"
    	"org.gnome.Nautilus"
    	"kitty"
    	"steam"
    	"org.qbittorrent.qBittorrent"
    	"com.github.johnfactotum.Foliate"
    	"spotify"
    	"md.obsidian.Obsidian"
    	"codium"
    	".virt-manager-wrapped"
  	"hydralauncher"
	];
   };
   settings = {
  lockScreenWidgetInstances = [
    {
      id = "lock_clock";
      widgetType = "desktopClock";
      enabled = true;
      config = {
        displayPreferences = [
          "all"
        ];
        syncPositionAcrossScreens = true;
        style = "expressive";
        transparency = 0;
        weight = 0;
        twoTone = true;
        showDate = false;
        showDigitalSeconds = false;
        showAnalogNumbers = false;
        showAnalogSeconds = true;
        autoPosition = true;
        colorMode = "default";
        customColor = "#ffffff";
      };
    }
    {
      id = "lock_date";
      widgetType = "lockDate";
      enabled = true;
      config = {
        displayPreferences = [
          "all"
        ];
        syncPositionAcrossScreens = true;
        format = "short";
        colorMode = "default";
        customColor = "#ffffff";
      };
    }
    {
      id = "lock_auth";
      widgetType = "lockAuth";
      enabled = true;
      config = {
        displayPreferences = [
          "all"
        ];
        syncPositionAcrossScreens = true;
        style = "expressive";
        profileVisibility = "always";
        passwordVisibility = "always";
      };
    }
    {
      id = "lock_notifications";
      widgetType = "lockNotifications";
      enabled = true;
      config = {
        displayPreferences = [
          "all"
        ];
        syncPositionAcrossScreens = true;
        mode = 2;
      };
    }
    {
      id = "lock_status";
      widgetType = "lockStatus";
      enabled = true;
      config = {
        displayPreferences = [
          "all"
        ];
        syncPositionAcrossScreens = true;
        showMediaPlayer = true;
        showWeather = true;
        background = false;
      };
    }
    {
      id = "lock_power";
      widgetType = "lockPower";
      enabled = false;
      config = {
        displayPreferences = [
          "all"
        ];
        syncPositionAcrossScreens = true;
        shape = "round";
      };
    }
  ];
  greeterWidgetInstances = [
    {
      id = "lock_clock";
      widgetType = "desktopClock";
      enabled = true;
      config = {
        displayPreferences = [
          "all"
        ];
        syncPositionAcrossScreens = true;
        style = "expressive";
        transparency = 0;
        weight = 0;
        twoTone = true;
        showDate = false;
        showDigitalSeconds = false;
        showAnalogNumbers = false;
        showAnalogSeconds = true;
        autoPosition = true;
        colorMode = "default";
        customColor = "#ffffff";
      };
    }
    {
      id = "lock_date";
      widgetType = "lockDate";
      enabled = true;
      config = {
        displayPreferences = [
          "all"
        ];
        syncPositionAcrossScreens = true;
        format = "short";
        colorMode = "default";
        customColor = "#ffffff";
      };
    }
    {
      id = "lock_auth";
      widgetType = "lockAuth";
      enabled = true;
      config = {
        displayPreferences = [
          "all"
        ];
        syncPositionAcrossScreens = true;
        style = "expressive";
        profileVisibility = "always";
        passwordVisibility = "always";
      };
    }
    {
      id = "lock_status";
      widgetType = "lockStatus";
      enabled = true;
      config = {
        displayPreferences = [
          "all"
        ];
        syncPositionAcrossScreens = true;
        showMediaPlayer = true;
        showWeather = true;
        background = false;
      };
    }
    {
      id = "lock_power";
      widgetType = "lockPower";
      enabled = false;
      config = {
        displayPreferences = [
          "all"
        ];
        syncPositionAcrossScreens = true;
        shape = "round";
      };
    }
    {
      id = "greeter_session";
      widgetType = "greeterSession";
      enabled = true;
      config = {
        displayPreferences = [
          "all"
        ];
        syncPositionAcrossScreens = true;
      };
    }
  ];
  blurBorderEnabled = false;
  useAutoLocation = true;
  fontFamily = "DejaVu Sans";
  monoFontFamily = "DejaVu Sans Mono";
  fontScale = 0.95;
  powerActionConfirm = false;
  dockConfigs = [
    {
      id = "dock";
      name = "Dock";
      enabled = true;
      screenPreferences = [
        "all"
      ];
      showOnLastDisplay = true;
      position = 1;
      mode = "compact";
      middleClickAction = "close";
      taskbarAlign = "center";
      widgetExpansion = "popout";
      iconSize = 50;
      spacing = 10;
      itemSpacing = 10;
      margin = 5;
      bottomGap = 0;
      transparency = 1;
      followInterfaceStyle = true;
      autoHide = true;
      smartAutoHide = false;
      useOverlayLayer = false;
      editOnRightClick = false;
      showOnFullscreen = false;
      openOnOverview = false;
      groupByApp = true;
      separatePinnedAndRunningApps = false;
      restoreSpecialWorkspaceOnClick = false;
      isolateDisplays = false;
      indicatorStyle = "line";
      borderEnabled = true;
      borderColor = "primary";
      borderOpacity = 1;
      borderThickness = 2;
      launcherEnabled = false;
      launcherLogoMode = "os";
      launcherLogoCustomPath = "";
      launcherLogoColorOverride = "";
      launcherLogoSizeOffset = 0;
      launcherLogoBrightness = 0.5;
      launcherLogoContrast = 1;
      maxVisibleApps = 0;
      maxVisibleRunningApps = 0;
      showOverflowBadge = true;
      showTrash = false;
      trashFileManager = "default";
      trashCustomCommand = "";
      magnification = false;
      magnificationScale = 130;
      magnificationProfile = "parabolic";
      magnificationExpand = false;
      order = [];
      widgets = [
        {
          id = "dock_launcher";
          widgetId = "dockLauncher";
          enabled = true;
        }
        {
          id = "dock_apps";
          widgetId = "appsDock";
          enabled = true;
          appsDockColorizeActive = false;
          appsDockActiveColorMode = "error";
        }
        {
          id = "dock_trash";
          widgetId = "dockTrash";
          enabled = true;
        }
      ];
    }
  ];
  popupTransparency = 1.0;
  dmsWindowsFloatingSeeded = [
    "niri"
  ];
  density = "comfortable";
  blurLayerOutlineOpacity = 0;
  blurWallpaperOnOverview = true;
  controlCenterWidgets = [
    {
      id = "user";
      enabled = true;
      w = 5;
      h = 1;
      col = 0;
      row = 0;
    }
    {
      id = "settings";
      enabled = true;
      w = 1;
      h = 1;
      small = true;
      col = 5;
      row = 0;
    }
    {
      id = "lock";
      enabled = true;
      w = 1;
      h = 1;
      small = true;
      col = 6;
      row = 0;
    }
    {
      id = "power";
      enabled = true;
      w = 1;
      h = 1;
      small = true;
      col = 7;
      row = 0;
    }
    {
      id = "brightnessSlider";
      enabled = true;
      w = 4;
      h = 1;
      small = true;
      col = 0;
      row = 1;
    }
    {
      id = "volumeSlider";
      enabled = true;
      w = 4;
      h = 1;
      small = true;
      col = 4;
      row = 1;
    }
    {
      id = "wifi";
      enabled = true;
      w = 4;
      h = 1;
      col = 0;
      row = 2;
    }
    {
      id = "bluetooth";
      enabled = true;
      w = 4;
      h = 1;
      col = 4;
      row = 2;
    }
    {
      id = "audioOutput";
      enabled = true;
      w = 4;
      h = 1;
      col = 0;
      row = 3;
    }
    {
      id = "audioInput";
      enabled = true;
      w = 4;
      h = 1;
      col = 4;
      row = 3;
    }
    {
      id = "doNotDisturb";
      enabled = true;
      w = 1;
      h = 1;
      col = 4.5;
      row = 5;
      small = true;
    }
    {
      id = "idleInhibitor";
      enabled = true;
      w = 1.5;
      h = 1;
      col = 6.5;
      row = 5;
      small = true;
    }
    {
      id = "battery";
      enabled = true;
      w = 4;
      h = 1;
      col = 4;
      row = 4;
    }
    {
      id = "diskUsage";
      enabled = true;
      w = 4;
      h = 1;
      col = 0;
      row = 4;
    }
    {
      id = "runningApps";
      enabled = true;
      w = 4.5;
      h = 1;
      small = true;
      col = 0;
      row = 5;
    }
    {
      id = "edit";
      enabled = true;
      w = 1;
      h = 1;
      small = true;
      col = 5.5;
      row = 5;
    }
  ];
  scrollTitleEnabled = true;
  audioVisualizerEnabled = true;
  appLauncherGridColumns = 3;
  dankLauncherV2Size = "compact";
  dankLauncherV2BorderEnabled = true;
  dankLauncherV2ShowFooter = false;
  dashOptions = {
    media = {
      playerStyle = "material";
      panelColumns = 5;
      artStyle = "rounded";
    };
  };
  wellbeingDailyLimit = 0;
  connectedFrameBarStyleBackups = {};
  barConfigs = [
    {
      centerWidgets = [
        "music"
        "clock"
        "weather"
      ];
      enabled = true;
      id = "default";
      leftWidgets = [
        {
          id = "launcherButton";
          enabled = true;
          launcherLogoMode = "os";
        }
        "workspaceSwitcher"
        "focusedWindow"
      ];
      name = "Main Bar";
      position = 0;
      rightWidgets = [
        {
          enabled = true;
          id = "systemTray";
        }
        {
          enabled = true;
          id = "dankKDEConnect";
        }
        {
          enabled = true;
          id = "clipboard";
        }
        {
          enabled = true;
          id = "cpuUsage";
        }
        {
          enabled = true;
          id = "memUsage";
        }
        {
          enabled = true;
          id = "notificationButton";
        }
        {
          enabled = true;
          id = "battery";
        }
        {
          enabled = true;
          id = "controlCenterButton";
        }
        {
          enabled = true;
          id = "controlPanel";
        }
      ];
      screenPreferences = [
        "all"
      ];
      showOnLastDisplay = true;
      innerPadding = 4;
      widgetPadding = 8;
      squareCorners = false;
      attachToScreenEdge = false;
      gothCornersEnabled = false;
      borderEnabled = true;
      borderColor = "primary";
      borderThickness = 2;
      iconScale = 1;
      spacing = 4;
      barLengthMode = "full";
      barLengthPadding = 0;
      widgetOutlineEnabled = true;
      widgetOutlineThickness = 2;
      widgetOutlineOpacity = 0.33;
      widgetStyle = "pills";
      widgetOutlineColor = "primary";
    }
    {
      centerWidgets = [
        "music"
        "clock"
        "weather"
      ];
      enabled = false;
      id = "dot1794854543589";
      leftWidgets = [
        {
          id = "launcherButton";
          enabled = true;
          launcherLogoMode = "os";
        }
        "workspaceSwitcher"
        "focusedWindow"
      ];
      name = "Dot";
      position = 0;
      rightWidgets = [
        {
          enabled = true;
          id = "systemTray";
        }
        {
          enabled = true;
          id = "dankKDEConnect";
        }
        {
          enabled = true;
          id = "clipboard";
        }
        {
          enabled = true;
          id = "cpuUsage";
        }
        {
          enabled = true;
          id = "memUsage";
        }
        {
          enabled = true;
          id = "notificationButton";
        }
        {
          enabled = true;
          id = "battery";
        }
        {
          enabled = true;
          id = "controlCenterButton";
        }
        {
          enabled = true;
          id = "controlPanel";
        }
      ];
      screenPreferences = [
        "all"
      ];
      showOnLastDisplay = true;
      innerPadding = 4;
      widgetPadding = 8;
      squareCorners = false;
      attachToScreenEdge = false;
      gothCornersEnabled = false;
      borderEnabled = true;
      borderColor = "primary";
      borderThickness = 2;
      iconScale = 1;
      spacing = 4;
      barLengthMode = "full";
      barLengthPadding = 0;
      widgetOutlineEnabled = true;
      widgetOutlineThickness = 2;
      widgetOutlineOpacity = 0.56;
      visible = true;
      autoHide = false;
      island = false;
      dot = true;
      followInterfaceStyle = false;
      transparency = 1;
    }
  ];
  builtInPluginSettings = {
    dms_qr_generator = {
      trigger = "qrg";
    };
    dms_power = {
      trigger = "pw";
    };
    dms_clipboard_search = {
      trigger = "cb";
    };
    dms_settings_search = {
      trigger = "?";
    };
  };
  frameEnabled = false;
  configVersion = 42;
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
      includes = {
      enable = false;
      override = false;
      };
   };
   enableDynamicTheming = false;  # Disables Matugen, which is useless with Stylix.
   };

}
