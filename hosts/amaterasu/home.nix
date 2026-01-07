{ config, cfg, pkgs, lib, inputs, stylix, ... }:

  let
  # Assigning a Python3 Environment for my RGB Control script.
  mypython = (pkgs.python3.withPackages (pythonPackages: with pythonPackages; [
      consul
  ]));
  in

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ladyhayya";
  home.homeDirectory = "/home/ladyhayya";
  
  xdg.userDirs = {
      enable = true;
      createDirectories = true;
  };

  xdg.mimeApps.defaultApplications = {
    "inode/directory" = ["nautilus.desktop"];
  };


  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05";

  # The home.packages option allows you to install Nix packages.
  home.packages = with pkgs; [
     # Fastfetch as fetch backend, Hyfetch for neofetch but PRIDE :3
     hyfetch
     fastfetch
     # Fonts needed for Powerlevel10k
     meslo-lgs-nf
     # Random apps I couldn't fit in a specific module :P
     qbittorrent # Torrent Client (QT)
     prismlauncher # Best Minecraft Launcher EVER (QT)
     winetricks
     p7zip
     celluloid # GNOME MPV Player
     image-roll # GNOME Image Viewer
     evince # GNOME Document Viewer
     snapshot # GNOME Camera
     foliate # GNOME E-Book Reader
     #sgdboop # Client for SteamGridDB
     # Scripts in Python
     (pkgs.writeScriptBin "rgb-control"
     ("#!${mypython}/bin/python3\n" + (builtins.readFile ./../../pkgs/acer-rgb-control.py)))
  ];
  
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

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

  # Enables two stylix modules and removes false alarm of mismatching versions (Pretty sure these are all useless, TODO: Remove this)
  stylix.targets.gtk.flatpakSupport.enable = true;
  #stylix.targets.qt = { 
  #	enable = true;
  #	platform = "qtct";
  #};
  stylix.enableReleaseChecks = false;

  # Enables the Gruvbox Plus icon theme for GTK apps.
  #gtk.iconTheme = {
  #    name = "Gruvbox-Plus-Dark";
  #    package = pkgs.gruvbox-plus-icons;
  #};

  # Enables the Gruvbox Plus icon theme for QT apps and DankMaterialShell.
  # xdg.configFile."qt6ct/qt6ct.conf".text = ''
  #	[Appearance]
#	custom_palette=true
#	style=kvantum
#	icon_theme=Gruvbox-Plus-Dark
#	[Fonts]
#	fixed="DejaVu Sans Mono,12"
#	general="DejaVu Sans,12"
#  '';
#   xdg.configFile."qt5ct/qt5ct.conf".text = ''
#  	[Appearance]
#	custom_palette=true
#	style=kvantum
#	icon_theme=Gruvbox-Plus-Dark
#	[Fonts]
#	fixed="DejaVu Sans Mono,12"
#	general="DejaVu Sans,12"
#  ''; 


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
  # 
  #
  #  /etc/profiles/per-user/ladyhayya/etc/profile.d/hm-session-vars.sh
  home.sessionVariables = {
    # EDITOR = "neovim"; 
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
