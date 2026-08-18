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
    ../../modules/hardware/opentabletdriver.nix
    ../../modules/desktops

    # System Modules 
    ../../modules/system/incus.nix 
    ../../modules/system/openssh.nix
    ../../modules/system/netbird.nix 
    ../../modules/system/base.nix

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

  mySystem.users.luigi.enable = true; 

  mySystem.hardware.opentabletdriver.enable = true;

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
