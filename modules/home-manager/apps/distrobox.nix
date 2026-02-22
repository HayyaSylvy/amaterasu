{

    programs.distrobox = {
	enable = true;
	settings = {
     		container_always_pull= 1;
     		container_manager="podman";
	};
	containers = {
  		debian = {
    		  additional_packages = "git";
    		  entry = false;
		  enableSystemdUnit = true;
    		  image = "quay.io/toolbx-images/debian-toolbox:latest";
  		};
  		arch = {
    		  additional_packages = "git base-devel";
    		  entry = false;
		  enableSystemdUnit = true;
    		  image = "quay.io/toolbx/arch-toolbox:latest";
  		};	
	};
    };

}
