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
	"Izanami" = {id = "B5LK5Q4-MZ7RRAH-HGXXFVG-RAANVBV-UW3DVQC-AOKUUVS-2GFSNOP-6OYDTQC"; };
     };
     folders = {
	"E-books" = {
		path = "/home/ladyhayya/Documents/E-books";
		devices = [ "Izanami" ];
		ignorePerms = true;
	};
	"Obsidian" = {
		path = "/home/ladyhayya/Documents/Obsidian";
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

