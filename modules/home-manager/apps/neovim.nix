{

  # Setups Nixvim to manage my Neovim configuration (which is pretty much ZERO right now.) 
  # TODO: Have a decent-ish Neovim configuration by when my classes at UFPB :P 
  programs.nixvim = {
       enable = true;
       plugins = {
       	  bufferline.enable = true;
	  cmp = {
	    enable = true;
	    autoEnableSources = true;
	    autoLoad = true;
	  };
	  nvim-tree = {
	    enable = true;
	    openOnSetup = true;
	  };
	  web-devicons.enable = true;
	  lsp = {
		enable = true;
		servers = {
		   nixd.enable = true;
		};
	  };
       };
  };


}
