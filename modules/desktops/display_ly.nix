{ config, lib, ... }:

let
  cfg = config.mySystem.desktops.display_ly;
in
{
  options.mySystem.desktops.display_ly = {
    enable = lib.mkEnableOption "Ly display manager";
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.ly.enable = true;
  };
}
