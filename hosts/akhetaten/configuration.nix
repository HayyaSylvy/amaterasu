# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, inputs, pkgs, stylix, ... }:

  #let acermodule = config.boot.kernelPackages.callPackage ./acer-rgb.nix {}; in

{
  # Is empty due to Flakes already importing what I need (for now at least)
  imports = [ 
    #./../../modules/nixos/flatpak.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  #boot.extraModulePackages = [ acermodule ];
  #boot.kernelModules = [ "facer" "wmi" "sparse-keymap" "video" ]; 

  boot.initrd.luks.devices."luks-d0910db7-64a9-40dd-8144-8be4a86ab0e8".device = "/dev/disk/by-uuid/d0910db7-64a9-40dd-8144-8be4a86ab0e8";
  networking.hostName = "akhetaten"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ladyhayya = {
    isNormalUser = true;
    description = "Lady Hayya";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ 
      mullvad-browser
      fuzzel
      git
      gh
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services.displayManager.sddm = {
     enable = true;
     wayland.enable = true;
  };

  programs.niri.enable = true;

  stylix = {
     enable = true;
     base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-medium.yaml";
     image = ./gruvy.png;
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
  ];

  # Enables Flakes (TDLR: Not sure if needed, here for... idk :P)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
  system.stateVersion = "25.05"; # Did you read the comment?

}
