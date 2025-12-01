{ config, pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ladyhayya";
  home.homeDirectory = "/home/ladyhayya";

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
  ];

  programs.nixvim.enable = true;
  programs.dankMaterialShell = {
  enable = true;
    niri = {
      enableKeybinds = true;   # Automatic keybinding configuration
      enableSpawn = true;      # Auto-start DMS with niri
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
  stylix.enableReleaseChecks = false;

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
