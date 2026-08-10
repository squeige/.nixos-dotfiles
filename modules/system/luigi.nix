{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.users.luigi;
in
{
  # 1. Declare the feature toggle
  options.mySystem.users.luigi = {
    enable = lib.mkEnableOption "Enable Luigi's primary user account";
  };

  # 2. Apply all system configuration ONLY when enabled
  config = lib.mkIf cfg.enable {
    users.users.luigi = {
      isNormalUser = true;
      description = "Luigi";
      extraGroups = [
        "wheel"          # Sudo access
        "networkmanager" # Network management
        "video"          # Brightness and display access
        "audio"          # Sound device access
      ];

      # SSH authorized keys specifically for Luigi
      openssh.authorizedKeys.keys = [
        # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI..."
      ];
    };
  };
}
