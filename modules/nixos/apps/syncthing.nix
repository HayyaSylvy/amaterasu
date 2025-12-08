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
     };
  };
};

}

