{ config, lib, ... }:

let
  cfg = config.mySystem.hardware.opentabletdriver;
in
{
  options.mySystem.hardware.opentabletdriver = {
    enable = lib.mkEnableOption "OpenTabletDriver for pen tablets";
  };

  config = lib.mkIf cfg.enable {
    hardware.opentabletdriver.enable = true;
    hardware.uinput.enable = true;
    boot.kernelModules = [ "uinput" ];
  };
}
