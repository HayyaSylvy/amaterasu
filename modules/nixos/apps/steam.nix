{ pkgs, ...}:
{
	# Basic setup to enable Steam, Gamemode and Gamescope (with HDR)
	programs.gamemode = {
		enable = true;
		enableRenice = true;
	};
        programs.gamescope = {
		enable = true;
		capSysNice = false;
	};
	programs.steam = {
		enable = true;
		protontricks.enable = true;
		package = pkgs.steam.override {
			extraEnv = {
        		 __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        		 __NV_PRIME_RENDER_OFFLOAD = "1";
        		 __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
        		 __VK_LAYER_NV_optimus = "NVIDIA_only";
			};
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

		];
		extraCompatPackages = with pkgs; [ proton-ge-bin ];
	};
	jovian.steam.enable = true;
	jovian.steamos.enableBluetoothConfig = true;
	jovian.decky-loader = {
	enable = true;
	user = "ladyhayya";
	};
	environment.systemPackages = with pkgs; [ 
		gamescope-wsi
	];

}
