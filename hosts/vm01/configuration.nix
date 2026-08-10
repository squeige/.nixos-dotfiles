{ config, lib, pkgs, inputs, herdr, ... }:

{
  imports = [
    ./hardware-configuration.nix

    # Reusable Hardware & System Modules
    ../../modules/hardware/audio.nix
    
    # Home Manager
    inputs.home-manager.nixosModules.home-manager
  ];

  # Hyper-V Guest Integration (clipboard, resolution scaling, dynamic memory)
  virtualisation.hypervGuest.enable = true;

  # Home Manager setup
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.luigi = import ../../home.nix;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs herdr; };
  };

  # Bootloader settings (EFI for Hyper-V Gen 2)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname & Networking
  networking.hostName = "vm01";
  networking.networkmanager.enable = true;

  # Time Zone & Display
  time.timeZone = "America/Costa_Rica";
  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
  };
  services.displayManager.ly.enable = true;

  # User Account
  users.users.luigi = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  # System Packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    tree
  ];

  # Nix Configuration
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05";
}
