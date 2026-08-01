{ pkgs, config, ...}:
{

  programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      localVariables = { 
        ZSH_DISABLE_COMPFIX = "true"; # Fixes VSCodium wrong shell warning
      };
      shellAliases = {
	"uprotina" = "cd .nix-desktop && sudo nix flake update && git add . && git commit -m Update de rotina && git push && sudo nixos-rebuild switch --flake ~/.nix-desktop#amaterasu --upgrade";
	"rmlixo" = "sudo nix-collect-garbage -d && sudo nixos-rebuild switch --flake ~/.nix-desktop#amaterasu";
      };
      # Makes it that .zshrc and other similar files are actually on a writable folder.
      dotDir = "${config.xdg.configHome}/zsh"; 
      oh-my-zsh = {
         enable = true;
         plugins = [ "git"];
      };
      # This fixes Powerlevel10k, I barely know why but it does :P
      initContent = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme 
      source ~/.config/zsh/.p10k.zsh
      export LD_LIBRARY_PATH=${pkgs.libGL}/lib/
      '';
  };

}
