# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, stylix, ... }:

let acermodule = config.boot.kernelPackages.callPackage ./../../pkgs/acer-rgb.nix {}; in

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
  
  # Enables my Acer RGB Keyboard to work properly.
  boot.extraModulePackages = [ acermodule ];
  boot.kernelModules = [ "facer" "wmi" "sparse-keymap" "video" ];
  
  # Enables XDG Desktop Portals for permission fixes.
  xdg.portal = { 
  	enable = true;
	extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  boot.initrd.luks.devices."luks-4b2cceb6-23eb-4e64-a942-7c10baf1fc8f".device = "/dev/disk/by-uuid/4b2cceb6-23eb-4e64-a942-7c10baf1fc8f";
  networking.hostName = "amaterasu"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
  
  # Enable X11 for compatibility reasons (and removex XTerm from it)
  services.xserver.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];

  # Enables Pipewire for sound support.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true; # Should already be enabled, just making sure.
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enables Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "America/Fortaleza";

  # Removes the Documentation App (Idk why this is preinstalled anyway :P)
  documentation.nixos.enable = false;

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
    packages = with pkgs; [ 
    nautilus
    xwayland-satellite
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
  ];

  # Allow usage of Kitty as terminal in Nautilus
  programs.nautilus-open-any-terminal = {
  	enable = true;
  	terminal = "kitty";
  };
 
  # Enables GVFS to fix bugs on Nautilus.
  services.gvfs.enable = true;


  # Enables Power Profile Daemon and Upower for (basic) perfomance control.
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true  
 
  # Enables Niri (Unstable) + DankMaterialGreeter
  programs.niri.enable = true;
  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/ladyhayya";
    configFiles = [
      "/home/ladyhayya/.config/DankMaterialShell/"
    ];
  };

  #services.displayManager.sddm = {
  #	enable = true;
  #	wayland.enable = true;
  #};
  
  # Enables Stylix for the whole system and it's apps.
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
	size = 26;
     };
     image = ./../../modules/home-manager/assets/gruvy.png;
     polarity = "dark";
     enableReleaseChecks = false;
  };

  # This SHOULD set my user picture. SHOULD
  # TLDR: No, this doesn't. TODO: Fix this.
  system.activationScripts.script.text = ''
      mkdir -p /var/lib/AccountsService/{icons,users}
      cp /home/ladyhayya/.nix-desktop/modules/home-manager/assets/icon.png /var/lib/AccountsService/icons/ladyhayya
      echo -e "[User]\nIcon=/var/lib/AccountsService/icons/ladyhayya\n" > /var/lib/AccountsService/users/ladyhayya

      chown root:root /var/lib/AccountsService/users/ladyhayya
      chmod 0600 /var/lib/AccountsService/users/ladyhayya

      chown root:root /var/lib/AccountsService/icons/ladyhayya
      chmod 0444 /var/lib/AccountsService/icons/ladyhayya
  '';

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall = { 
    enable = true;
    allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
    allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  }; 

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
