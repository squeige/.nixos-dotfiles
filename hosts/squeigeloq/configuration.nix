
{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "squeigeloq"; 
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Costa_Rica";
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.qtile.enable  = true;
  };
  services.displayManager.ly.enable = true;
  
  users.users.luigi = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
     ];
   };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim 
    wget
    curl
    git
    tree
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.meslo-lg
    nerd-fonts.symbols-only
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
 
  nixpkgs.config.allowUnfree = true;

  console = {
    font = "latarcyrheb-sun32"; # A large, clean 32pt monospace font
   };

  # Limit the number of generations stored in /boot to prevent it from ever filling up
  boot.loader.systemd-boot.configurationLimit = 12;



  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  #system.copySystemConfiguration = true;
  system.stateVersion = "26.05"; 
}

