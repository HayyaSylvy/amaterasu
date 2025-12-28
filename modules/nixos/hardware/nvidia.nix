{ pkgs, config, ...}:

{

   hardware.graphics.enable = true;
   services.xserver.videoDrivers = [
   	"amdgpu"
	"nvidia" 
   ];
   hardware.nvidia = {
	open = false;
	package = config.boot.kernelPackages.nvidiaPackages.stable;
	nvidiaPersistenced = true;
	modesetting.enable = true;
	prime = {
	    offload = {
	    enable = true;
	    enableOffloadCmd = true;
	    };
	    amdgpuBusId = "PCI:74:0:0";
	    nvidiaBusId = "PCI:01:0:0";
	};
   };

}
