{ config, lib, pkgs, ... }:

{
  services.logind.settings = {
    Login = {
      # Power button puts the system to sleep
      HandlePowerKey = "suspend";
    };
  };

  # Idle suspend is handled by swayidle, which is spawned from the niri config:
  #   spawn-at-startup "swayidle" "-w" "timeout" "900" "systemctl suspend"
  # (logind's IdleAction requires the desktop environment to report the session
  # idle hint, which niri does not do.)
  environment.systemPackages = with pkgs; [
    swayidle
  ];
}
