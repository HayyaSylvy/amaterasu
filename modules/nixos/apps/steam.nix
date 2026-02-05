{ pkgs, ...}:
{
	# Basic setup to enable Steam, Gamemode and Gamescope (with HDR)
	programs.gamemode = {
		enable = true;
		enableRenice = true;
	};
        programs.gamescope = {
		enable = true;
		#capSysNice = false;
	};
	programs.steam = {
		enable = true;
		protontricks.enable = true;
		package = pkgs.steam.override {
		#	extraEnv = {
        	#	 __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        	#	 __NV_PRIME_RENDER_OFFLOAD = "1";
        	#	 __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
        	#	 __VK_LAYER_NV_optimus = "NVIDIA_only";
		#	};
		extraLibraries = pkgs: [ pkgs.xorg.libxcb ];
        	extraPkgs =
          	pkgs: with pkgs; [
            	xorg.libXcursor
            	xorg.libXi
            	xorg.libXinerama
            	xorg.libXScrnSaver
            	libpng
            	libpulseaudio
            	libvorbis
            	stdenv.cc.cc.lib
            	libkrb5
            	keyutils
            	gamemode
          	];
		};
		extraPackages = with pkgs; [
			gamescope
			gamescope-wsi
			bluez
			gamemode
			mangohud
			brotli
			gcc
			glibc
			libidn2
			libnghttp2
			libssh2
			openssl
			zlib
			zstd
			sudo
			python3
			xorg.libxcb
	    		xorg.libXcursor
            		xorg.libXi
            		xorg.libXinerama
            		xorg.libXScrnSaver
            		libpng
            		libpulseaudio
            		libvorbis
            		stdenv.cc.cc.lib
            		libkrb5
            		keyutils
            		gamemode
		];
		extraCompatPackages = with pkgs; [ proton-ge-bin ];
	};
	jovian.steam.enable = true;
	jovian.steamos.enableBluetoothConfig = true;
	jovian.decky-loader = {
		enable = true;
		user = "ladyhayya";
		plugins = with pkgs.decky-plugins; [
		protondb_badges
		css_loader
		];
	};
	environment.systemPackages = with pkgs; [ 
		gamescope
		gamescope-wsi
	];

}
