{ config, pkgs, ... }:

{
  # ==========================================
  # 1. BOOT, KERNEL & SLEEP CONFIGURATION
  # ==========================================
  boot.kernelParams = [
    "resume=UUID=460bd9d4-638a-4c9f-ade5-4ffa74a4d4fb"
    "rtc_cmos.use_acpi_alarm=1"
    "acpi_backlight=native"
  ];

  boot.initrd.supportedFilesystems = [ "btrfs" ];
  boot.resumeDevice = "/dev/disk/by-uuid/460bd9d4-638a-4c9f-ade5-4ffa74a4d4fb";

  # Ensure native hardware ACPI modules are loaded early
  boot.kernelModules = [ "ideapad_laptop" ];
  hardware.acpilight.enable = true;

  services.logind.settings = {
    Login = {
      # Add this line to map power button press to suspend
      HandlePowerKey = "suspend";

      # Hibernate directly on lid close: suspend-then-hibernate crashed the
      # NVIDIA driver (595) during the s2idle→hibernate handoff (Aug 2026), so
      # skip suspend entirely and write RAM to the swap file.
      HandleLidSwitch = "hibernate";
      HandleLidSwitchExternalPower = "hibernate";
      # Inactivity trigger: hibernate (niri doesn't report the idle hint, so
      # this stays dormant)
      IdleAction = "hibernate";
      IdleActionSec = "900";
    };
  };

  systemd.sleep.settings = {
    Sleep = { };
  };

  # ==========================================
  # 2. TLP POWER MANAGEMENT & BATTERY CARE
  # ==========================================
  services.power-profiles-daemon.enable = false;

  services.tlp = {
    enable = true;
    settings = {
      # Default scaling governor
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      
      # Balanced responsiveness on AC, maximum power saving on battery
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      # Balanced profile (White LED) when plugged in, low-power (Blue LED) on battery
      PLATFORM_PROFILE_ON_AC = "balanced";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      # Battery health conservation thresholds
      START_CHARGE_THRESH_BAT0 = "75";
      STOP_CHARGE_THRESH_BAT0 = "80";
    };
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];
}


