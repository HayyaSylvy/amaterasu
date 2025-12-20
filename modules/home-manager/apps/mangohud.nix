{ pkgs, ...}:
{

  # Enables Mangohud
  programs.mangohud = {
      enable = true;
      package = pkgs.mangohud;
      settings = { 
	"cpu_temp" = true;
	"gpu_temp" = true;
      };
  };

}
