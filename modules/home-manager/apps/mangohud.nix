{ pkgs, ...}:
{

  # Enables Mangohud
  programs.mangohud = {
      enable = true;
      package = pkgs.mangohud;
      settings = { };
  };

}
