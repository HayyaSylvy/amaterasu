{ pkgs, ...}:
{
  # Declarative setup some of Zen's configurations. It still requires Firefox Sync for my extensions and some minor stuff.
  programs.zen-browser = {
       enable = true;
       setAsDefaultBrowser = true;
       policies = {
         AutofillAddressEnabled = true;
    	 AutofillCreditCardEnabled = false;
    	 DisableAppUpdate = true;
    	 DisableFeedbackCommands = true;
    	 DisableTelemetry = true;
    	 DontCheckDefaultBrowser = true;
    	 NoDefaultBookmarks = true;
    	 OfferToSaveLogins = false;
	 GenerativeAI = false;
    	 EnableTrackingProtection = {
      		Value = true;
      		Locked = true;
      		Cryptomining = true;
      		Fingerprinting = true;
    	 };
       };
       profiles = {
          "lady-of-war.default" = { # Don't ask me why this called Lady of War, I just think the name is neat for my browser :3
             extensions.force = true;
	     spacesForce = true;
	     spaces = {
		"Personal-stuff :P" = {
			icon = "🎮";
			id = "c6de089c-410d-4206-961d-ab11f988d40a";
			position = 100;
		};
		"Studies and Projects" = {
			icon = "💻";
			id = "a6de089c-410d-4206-961d-ab11f988d40a";
			position = 1000;
		};
	     };
	     spaceRouting = {
		defaultExternalRoute = "a6de089c-410d-4206-961d-ab11f988d40a";
		routes = {
			"github" = {
          			reference = "github.com";
          			matchType = "contains"; # default
          			openIn = "a6de089c-410d-4206-961d-ab11f988d40a";
        		};
        		"reddit" = {
          			reference = "reddit.com";
          			matchType = "equal-to";
          			openIn = "a6de089c-410d-4206-961d-ab11f988d40a";
        		};
		};
	     };
	     settings = {
	     	"zen.view.sidebar-expanded" = true;
	     	"zen.view.use-single-toolbar" = false;
	     	"browser.ai.control.default" = "blocked";
      		"browser.ai.control.linkPreviewKeyPoints" = "blocked";
      		"browser.ai.control.pdfjsAltText" = "blocked";
      		"browser.ai.control.sidebarChatbot" = "blocked";
      		"browser.ai.control.smartTabGroups" = "blocked";
      		"browser.ai.control.translations" = "blocked";
		"zen.urlbar.replace-newtab" = false;
	     };
	     # Setups options regarding search engine
	     search = {
	        force = true;
	        default = "ddg";#RIP Whoogle, wish I could have used you :(
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
  # Configuring Stylix so it targets the right Zen Browser profile.
  stylix.targets.zen-browser = {
       profileNames = [ "lady-of-war.default" ];
       enable = true;
  };

}
