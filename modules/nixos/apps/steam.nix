{ pkgs, ...}:
{
	# Basic setup to enable Steam, Gamemode and Gamescope (with HDR)
	programs.gamemode = {
		enable = true;
		enableRenice = true;
	};
	jovian.steam = {
		enable = true;
	};
	programs.steam = {
		enable = true;
		protontricks.enable = true;
		extraPackages = with pkgs; [
			gamescope
			gamescope-wsi
			bluez
			gamemode
			mangohud # Installed just for Steam, configured in the home-manager module.
			brotli
			gcc
			glibc
			libidn2
			libnghttp2
			libssh2
			openssl
			zlib
			zstd

		];
		extraCompatPackages = with pkgs; [ proton-ge-bin ];
	};
	jovian.steamos.enableBluetoothConfig = true;
	environment.systemPackages = with pkgs; [ 
		gamescope-wsi
	];

}
