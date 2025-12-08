{

services.syncthing = {
  enable = true;
  openDefaultPorts = true;
  user = "ladyhayya";
  configDir = "/home/ladyhayya/.config/syncthing";
  settings = {
     gui = {
    	user = "Hayya";
   	password = "youwillbefine";
     };
     devices = {
	"Izanami" = {id = "IUULXZK-7PRAZT2-XGKFTLG-XTKBYZZ-SP2DNIQ-ZAQINEJ-HSVCKGZ-D6C35AO"; };
     };
     folders = {
	"E-books" = {
		path = "/home/ladyhayya/Documents/E-books";
		devices = [ "Izanami" ];
		ignorePerms = true;
	};
	"GBA Roms" = {
		path = "/home/ladyhayya/Gaming.nix/Roms/GBA";
		devices = [ "Izanami" ];
	};
	"DS Roms" = {
		path = "/home/ladyhayya/Gaming.nix/Roms/DS";
		devices = [ "Izanami" ];
	};
	"3DS Roms" = {
		path = "/home/ladyhayya/Gaming.nix/Roms/3DS";
		devices = [ "Izanami" ];
	};	
	"PSP Roms" = {
		path = "/home/ladyhayya/Gaming.nix/Roms/PSP";
		devices = [ "Izanami" ];
	};
     };
  };
};

}

