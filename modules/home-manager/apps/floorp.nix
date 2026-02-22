{ pkgs, ...}:
{
  # Declarative setup some of Floorp's configurations. It still requires Firefox Sync for my extensions and some minor stuff.
  programs.floorp = {
       enable = true;
       package = pkgs.floorp-bin;
       profiles = {
          "lady-of-war.default" = { # Don't ask me why this called Lady of War, I just think the name is neat for my browser :3
             extensions.force = true;
	     # Setups options regarding search engine
	     search = {
	        force = true;
	        default = "ddg"; # RIP Whoogle, wished I could use you :(
		engines = {
              	    "Nix Packages" = {
                      urls = [{
        		template = "https://search.nixos.org/packages";
                  	params = [
                    	  { name = "type"; value = "packages"; }
                    	  { name = "query"; value = "{searchTerms}"; }
                  	];
                      }];
                      definedAliases = [ "@np" ];
                    };
              	    "NixOS Options" = {
                      urls = [{
        		template = "https://search.nixos.org/options";
                  	params = [
                    	  { name = "type"; value = "options"; }
                    	  { name = "query"; value = "{searchTerms}"; }
                  	];
                      }];
                      definedAliases = [ "@no" ];
                    };
              	    "Home Manager Options" = {
                      urls = [{
        		template = "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";
                      }];
                      definedAliases = [ "@hm" ];
                    };
	        };
	     };
	  };
       };
  };
  # Configuring Stylix so it targets the right Floorp profile and uses the Gnome CSS Theme.
  stylix.targets.floorp = {
       profileNames = [ "lady-of-war.default" ];
       enable = true;
       colorTheme.enable = true;
       firefoxGnomeTheme.enable = true;
  };

}
