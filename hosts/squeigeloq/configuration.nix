{ config, lib, pkgs, inputs, herdr, ... }:

{
  imports = [
    ./hardware-configuration.nix

    # Hardware Modules
    ../../modules/hardware/audio.nix
    ../../modules/hardware/lanzaboote.nix
    ../../modules/system/openssh.nix

    # Import Lenovo Loq specific hardware
    ./hardware

    # System Modules
    ../../modules/system/incus.nix

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
    extraSpecialArgs = { inherit inputs herdr; };
  };

  # Bootloader settings
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 12;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking
  networking.hostName = "squeigeloq";
  networking.networkmanager.enable = true;

  # Locale & Display
  time.timeZone = "America/Costa_Rica";
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.qtile.enable = true;
  };

  services.displayManager.ly.enable = true;

  mySystem.users.luigi.enable = true;

  # System packages & Fonts
  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    tree
    gcc
    gnumake
    tree-sitter
    ripgrep     # Needed for Telescope live_grep
    fd          # Optional, speeds up Telescope file searches
    unzip       # Needed by Mason to unpack language servers
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
