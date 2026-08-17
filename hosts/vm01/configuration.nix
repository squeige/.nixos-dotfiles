{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    # Reusable Hardware & System Modules
    ../../modules/hardware/audio.nix
    ../../modules/desktops
    ../../modules/system/luigi.nix
    ../../modules/system/netbird.nix
    ../../modules/system/base.nix

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

  mySystem.users.luigi.enable = true;

  # Desktop environment (see modules/desktops/)
  mySystem.desktops = {
    qtile.enable = true;
    display_ly.enable = true;
  };

  # Nix Configuration
  boot.loader.systemd-boot.configurationLimit = 12;

  system.stateVersion = "26.05";
}
