{ pkgs, lib, config, ...}:

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

  # Creates a Specialisation that disables the NVIDIA dGPU.
  # This boosts the battery life of this laptop by A LOT, plus the AMDGPU is pretty good on its own for lighter tasks.
  # A reminder to the future Hannah: Please don't use default config when NOT connected to the power supply, it is pretty damn inneficient.
  specialisation.unimode.configuration = {
    services.xserver.videoDrivers = lib.mkForce [ "amdgpu" ];
    powerManagement.powertop.enable = true;
    boot.extraModprobeConfig = ''
    blacklist nouveau
    options nouveau modeset=0
  '';
  services.udev.extraRules = ''
    # Remove NVIDIA USB xHCI Host Controller devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA USB Type-C UCSI devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA Audio devices, if present
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
    # Remove NVIDIA VGA/3D controller devices
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
  '';
  boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
  };

}
