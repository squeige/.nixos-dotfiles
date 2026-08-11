{ ... }:

{
  services.xserver = {
    enable = true; # Required for X11 backend
    windowManager.qtile = {
      enable = true;
      # extraPortPortalPackage = pkgs.xdg-desktop-portal-wlr; # Optional for Wayland backend
    };
  };
}
