{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.mySystem.desktops.niri;
in
{
  # niri-flake gates its own config behind programs.niri.enable (default false),
  # so importing unconditionally is safe even on hosts where niri is disabled.
  imports = [
    inputs.niri.nixosModules.niri
  ];

  options.mySystem.desktops.niri = {
    enable = lib.mkEnableOption "Niri Wayland compositor";
  };

  config = lib.mkIf cfg.enable {
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
      ];
    };

    programs.xwayland.enable = true;

    environment.systemPackages = with pkgs; [
      fuzzel
      mako
      waybar
      swaybg
      xwayland-satellite
    ];
  };
}
