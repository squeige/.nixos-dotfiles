{ config, lib, ... }:

let
  cfg = config.mySystem.desktops.qtile;
in
{
  options.mySystem.desktops.qtile = {
    enable = lib.mkEnableOption "Qtile window manager";
  };

  config = lib.mkIf cfg.enable {
    services.xserver = {
      enable = true; # Required for X11 backend
      windowManager.qtile = {
        enable = true;
        # extraPortPortalPackage = pkgs.xdg-desktop-portal-wlr; # Optional for Wayland backend
      };
    };
  };
}
