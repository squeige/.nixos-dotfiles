{ config, lib, pkgs, inputs, ... }: 

{ 
  imports = [ 
    ./hardware-configuration.nix 

    ../../modules/hardware/audio.nix 
    ../../modules/hardware/lanzaboote.nix 
    ../../modules/hardware/power.nix 
    ../../modules/system/bluetooth.nix 

   # ./hardware 
    ../../modules/hardware/nvidia.nix
    ../../modules/desktops

    # System Modules 
    ../../modules/system/incus.nix 
    ../../modules/system/openssh.nix
    ../../modules/system/netbird.nix

    # Home Manager NixOS Module (from flake input) 
    inputs.home-manager.nixosModules.home-manager 

    # Import users 
    ../../modules/system/luigi.nix 

  ]; 
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Home Manager inline setup 
  home-manager = { 
    useGlobalPkgs = true; 
    useUserPackages = true;
    users.luigi = { 
      imports = [ ../../modules/home/default.nix ]; 
    };
    backupFileExtension = "backup"; 
    extraSpecialArgs = { inherit inputs; }; 
  }; 

  # Bootloader settings 
  # boot.loader.systemd-boot.enable = true; # Managed with lanzaboote 
  # boot.loader.efi.canTouchEfiVariables = true; # Managed with lanzaboote 
  boot.loader.systemd-boot.configurationLimit = 12; 
  boot.kernelPackages = pkgs.linuxPackages_latest; 

  # Networking 
  networking.hostName = "squeigedesk"; 
  networking.networkmanager.enable = true; 

  # Locale & Display # Section comment for time zone and display settings
  time.timeZone = "America/Costa_Rica"; # Sets the local system time zone to Costa Rica

  mySystem.users.luigi.enable = true; 

  # Desktop environment (see modules/desktops/)
  mySystem.desktops = {
    niri.enable = true;
    display_ly.enable = true;
  };

  #programs.firefox.enable = true; 
  environment.systemPackages = with pkgs; [
    # Rescue / essential tools (keep minimal; user apps live in home-manager)
    vim 
    wget
    curl
  ];

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
