{ lib, ... }: 
{

   services.flatpak = {
        enable = true;
        update.onActivation = true;
        remotes = [ 
          { name = "flathub"; location = "https://flathub.org/repo/flathub.flatpakrepo"; } 
        ];
        packages = [
          "md.obsidian.Obsidian"
          "org.prismlauncher.PrismLauncher"
        ];
   };

}
