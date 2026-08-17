{ config, lib, pkgs, inputs, ... }: 

{ 
  imports = [ 
    ./hardware-configuration.nix 

    ../../modules/hardware/audio.nix 
    ../../modules/hardware/lanzaboote.nix 
    ../../modules/system/bluetooth.nix 
    ../../modules/system/openssh.nix 

    ./hardware # Import all Lenovo Loq modules

    ../../modules/desktops

    # System Modules 
    ../../modules/system/incus.nix
    ../../modules/system/netbird.nix
    ../../modules/system/base.nix

    # Home Manager NixOS Module (from flake input) 
    inputs.home-manager.nixosModules.home-manager 

    # Import users 
    ../../modules/system/luigi.nix 

  ]; 

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
  networking.hostName = "squeigeloq"; 
  networking.networkmanager.enable = true; 

  mySystem.users.luigi.enable = true; 

  # Desktop environment (see modules/desktops/)
  mySystem.desktops = {
    niri.enable = true;
    display_ly.enable = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono 
    nerd-fonts.fira-code 
    nerd-fonts.hack 
    nerd-fonts.meslo-lg 
    nerd-fonts.symbols-only 
  ]; 

  console = { 
    font = "latarcyrheb-sun32"; 
  }; 

  system.stateVersion = "26.05"; 
} 
