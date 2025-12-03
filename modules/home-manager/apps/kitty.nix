{
  # Configures the Kitty Terminal (AKA: Best terminal in features, plus its name and icons are soo cute :3)
  programs.kitty = { 
    enable = true;
    settings = { 
      # Configures the tabs to like I want them to :)
      tab_bar_min_tabs = 1;
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
    };
    keybindings = {
      # Keybinds to actually make tabs useful
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
    # Some Transparency and Blur, because why not :3? (PS: Going to regret having a transparent code editor in the future ain't I?)
    extraConfig = ''
      background_opacity 0.95
      background_blur 32
    '';
  };

}
