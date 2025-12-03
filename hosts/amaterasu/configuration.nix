# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, stylix, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices."luks-4b2cceb6-23eb-4e64-a942-7c10baf1fc8f".device = "/dev/disk/by-uuid/4b2cceb6-23eb-4e64-a942-7c10baf1fc8f";
  networking.hostName = "amaterasu"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enables Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "America/Fortaleza";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enables the ZSH shell (configured later by Home Manager)
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ladyhayya = {
    isNormalUser = true;
    description = "Lady Hayya";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    floorp-bin
    kitty
    fuzzel
    nautilus
  ];

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "kitty";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
 
  # Enables Niri + DankMaterialGreeter
  programs.niri.enable = true;  
  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor.name = "niri";  # Or "hyprland" or "sway"
    configFiles = [
      "/home/ladyhayya/.config/DankMaterialShell/settings.json"
    ];
  };

  stylix = {
     enable = true;
     base16Scheme = {
    	base00 = "282828";
    	base01 = "3c3836";
    	base02 = "504945";
    	base03 = "665c54";
    	base04 = "bdae93";
    	base05 = "d5c4a1";
    	base06 = "ebdbb2";
    	base07 = "fbf1c7";
    	base0D = "fb4934"; # Red
    	base09 = "fe8019";
    	base0A = "fabd2f";
    	base0B = "b8bb26";
    	base0C = "8ec07c";
    	base08 = "83a598"; #Blue
    	base0E = "d3869b";
	base0F = "d65d0e";
     };
     cursor = {
        name = "Capitaine Cursors (Gruvbox)";
	package = pkgs.capitaine-cursors-themed;
     };
     image = ./gruvy.png;
     enableReleaseChecks = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
