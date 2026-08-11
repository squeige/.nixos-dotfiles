{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.niri.nixosModules.niri
  ];

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
    wezterm
    fuzzel
    mako
    waybar
    swaybg
    xwayland-satellite
  ];
}

