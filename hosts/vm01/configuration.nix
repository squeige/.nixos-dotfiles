{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    # Reusable Hardware & System Modules
    ../../modules/hardware/audio.nix
    ../../modules/desktops
    ../../modules/system/luigi.nix

    # Home Manager
    inputs.home-manager.nixosModules.home-manager
  ];

  # Hyper-V Guest Integration (clipboard, resolution scaling, dynamic memory)
  virtualisation.hypervGuest.enable = true;

  # Home Manager setup
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.luigi = {
      imports = [ ../../modules/home/default.nix ];
    };
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };
  };

  # Bootloader settings (EFI for Hyper-V Gen 2)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname & Networking
  networking.hostName = "vm01";
  networking.networkmanager.enable = true;

  # Time Zone & Display
  time.timeZone = "America/Costa_Rica";

  mySystem.users.luigi.enable = true;

  # Desktop environment (see modules/desktops/)
  mySystem.desktops = {
    qtile.enable = true;
    display_ly.enable = true;
  };

  # System Packages (rescue / essential only; user apps live in home-manager)
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
  ];

  # Nix Configuration
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05";
}
