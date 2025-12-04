{ pkgs, inputs, spicetify-nix, ...}:

let
  spicetify = spicetify-nix.lib.mkSpicetify pkgs {};
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in

{
	programs.spicetify = {
		enable = true;
		enabledExtensions = with spicePkgs.extensions; [
       			adblockify
			fullAppDisplay
       			hidePodcasts
     		];
		wayland = true;
	};
}
