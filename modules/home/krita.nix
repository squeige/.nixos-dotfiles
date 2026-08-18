{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.home.krita;
in
{
  # Desktop-only app; laptop shouldn't carry it.
  options.mySystem.home.krita = {
    enable = lib.mkEnableOption "Krita for luigi";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.luigi.home.packages = [ pkgs.krita ];
  };
}