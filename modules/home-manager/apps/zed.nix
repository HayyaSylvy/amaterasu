{

	programs.zed-editor = {
		enable = true;
		extensions = [ "nix" ];
		userSettings = {
		   features = {
    		      copilot = false;
		      edit_prediciton_provider= "none";
		      disable_ai = true;
  		   };
  		   telemetry = {
    		      metrics = false;
		      diagnostic = false;
  		   };
		   vimMode = true;
		   agent.enabled = false;
		};
	};

}
