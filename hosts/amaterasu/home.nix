{ config, cfg, pkgs, lib, inputs, stylix, ... }:

  let
  # Assigning a Python3 Environment for my RGB Control script.
  mypython = (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [
      consul
  ]));
  in

{
  # Home Manager needs information about you and the paths it manages.
  home.username = "ladyhayya";
  home.homeDirectory = "/home/ladyhayya";
  
  # Create the default directories you expect in the home folder.
  xdg.userDirs = {
      enable = true;
      createDirectories = true;
  };
  
  # Sets Nautilus as the default file browser.
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = ["nautilus.desktop"];
  };

  # This value determines the Home Manager release that your configuration is compatible with. You should not change this value, even if you update Home Manager. If you do want to update the value, make sure to first check the Home Manager release notes.
  home.stateVersion = "26.11";

  # The home.packages option allows you to install Nix packages.
  home.packages = with pkgs; [
     # Fastfetch as Hyfetch backend, Hyfetch for neofetch but PRIDE :3
     hyfetch
     fastfetch
     # Fonts needed for Powerlevel10k
     meslo-lgs-nf
     noto-fonts-cjk-sans
     # Random apps I couldn't fit in a specific module :P
     qbittorrent # Torrent Client (QT)
     prismlauncher # Best Minecraft Launcher EVER (QT)
     kdePackages.filelight
     winetricks
     heroic
     rclone
     hydralauncher
     protonplus
     kdePackages.filelight
     celluloid # GNOME MPV Player
     image-roll # GNOME Image Viewer
     evince # GNOME Document Viewer
     snapshot # GNOME Camera
     foliate # GNOME E-Book Reader
     sushi # GNOME Nautilus Previewer
     gnome-text-editor # GNOME Text Editor, duh :P
     # Scripts in Python
     (pkgs.writeScriptBin "rgb-control"
     ("#!${mypython}/bin/python3\n" + (builtins.readFile ./../../pkgs/acer-rgb-control.py)))
  ];

  # Configure Hyfetch so it uses the Trans flag. I'm letting it here because why not? I'M TRANS WITH PRIDE GIRL :3
  xdg.configFile."hyfetch.json".text = ''
    {
    "preset": "transbian",
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

  # Enables stylix modules and removes the false alarms.
  stylix.targets.gtk.flatpakSupport.enable = true;
  #stylix.targets.qt = { 
  #	enable = true;
  #	platform = "qtct";
  #};
  stylix.enableReleaseChecks = false;

  # Fixes QT Theming with Stylix (PS: Thank you kind stranger who made this, because I don't understand a line of this code but it works :P)
  xdg.configFile.kdeglobals.source =
    let
      themePackage = builtins.head (
        builtins.filter (
          p: builtins.match ".*stylix-kde-theme.*" (builtins.baseNameOf p) != null
        ) config.home.packages
      );
      colorSchemeSlug = lib.concatStrings (
        lib.filter lib.isString (builtins.split "[^a-zA-Z]" config.lib.stylix.colors.scheme)
      );
    in
    "${themePackage}/share/color-schemes/${colorSchemeSlug}.colors";

  # Home Manager also manages your environment variables through 'home.sessionVariables'.
  home.sessionVariables = {
    EDITOR = "nvim"; 
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
