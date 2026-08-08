
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
    wezterm
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

