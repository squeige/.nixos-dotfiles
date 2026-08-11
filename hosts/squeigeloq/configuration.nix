{ config, lib, pkgs, inputs, ... }: 

{ 
  imports = [ 
    ./hardware-configuration.nix 

    ../../modules/hardware/audio.nix 
    ../../modules/hardware/lanzaboote.nix 
    ../../modules/system/openssh.nix 

    ./hardware # Import all Lenovo Loq modules

    ../../modules/desktops/niri.nix 

    # System Modules 
    ../../modules/system/incus.nix 
   # ../../modules/desktops/x11.nix
    ../../modules/desktops/display_ly.nix

    # Home Manager NixOS Module (from flake input) 
    inputs.home-manager.nixosModules.home-manager 

    # Import users 
    ../../modules/system/luigi.nix 

  ]; 

  # Home Manager inline setup 
  home-manager = { 
    useGlobalPkgs = true; 
    useUserPackages = true;
    users.luigi = import ../../home.nix; 
    backupFileExtension = "backup"; 
    extraSpecialArgs = { inherit inputs; }; 
  }; 

  # Bootloader settings 
  # boot.loader.systemd-boot.enable = true; # Managed with lanzaboote 
  # boot.loader.efi.canTouchEfiVariables = true; # Managed with lanzaboote 
  boot.loader.systemd-boot.configurationLimit = 12; 
  boot.kernelPackages = pkgs.linuxPackages_latest; 

  # Networking 
  networking.hostName = "squeigeloq"; 
  networking.networkmanager.enable = true; 

  # Locale & Display # Section comment for time zone and display settings
  time.timeZone = "America/Costa_Rica"; # Sets the local system time zone to Costa Rica

  mySystem.users.luigi.enable = true; 

  #programs.firefox.enable = true; 
  environment.systemPackages = with pkgs; [
    vim 
    wget
    curl
    git 
    tree
    gcc 
    gnumake 
    tree-sitter 
    ripgrep     
    fd         
    unzip
    bluez
    bluez-tools
    zed-editor
  ];

  # Enable Bluetooth hardware service
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono 
    nerd-fonts.fira-code 
    nerd-fonts.hack 
    nerd-fonts.meslo-lg 
    nerd-fonts.symbols-only 
  ]; 

  # Allow unfree, like nvidia. 
  nixpkgs.config.allowUnfree = true; 

  console = { 
    font = "latarcyrheb-sun32"; 
  }; 

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 
  system.stateVersion = "26.05"; 
} 
