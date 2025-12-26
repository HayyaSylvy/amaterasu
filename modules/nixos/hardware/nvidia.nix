{ pkgs, config, ...}:

{

   hardware.graphics.enable = true;
   services.xserver.videoDrivers = [ 
   	"amdgpu"
   	"nvidia" 
   ];
   hardware.nvidia = {
	open = false;
	#nvidiaPersistenced = true;
	prime = {
	    offload = {
	    enable = true;
	    enableOffloadCmd = true;
	    };
	    amdgpuBusId = "PCI:74:0:0";
	    nvidiaBusId = "PCI:1:0:0";
	};
   };

}
