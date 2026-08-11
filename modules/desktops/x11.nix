{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.desktops.x11;
in
{
  options.mySystem.desktops.x11 = {
    enable = lib.mkEnableOption "X11 server (xserver)";
  };

  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable = true;
      autoRepeatDelay = 200;
      autoRepeatInterval = 35;
    };
  };
}
