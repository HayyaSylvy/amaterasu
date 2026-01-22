{
   programs.nix-monitor = {
        enable = true;          
        # Required: customize for your setup
        rebuildCommand = [ 
           "bash" "-c" 
           "sudo nixos-rebuild switch --flake ~/.nix-desktop#amaterasu 2>&1"
        ];
	gcCommand = [ 
    	   "bash" "-c" 
 	   "sudo nix-collect-garbage -d 2>&1" 
  	];
   };
}
