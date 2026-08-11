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
  boot.kernelModules = [ "ideapad_laptop" "lenovo_wmi" ];
  hardware.acpilight.enable = true;

  services.logind.settings = {
    Login = {
      # Add this line to map power button press to suspend
      HandlePowerKey = "suspend";

      HandleLidSwitch = "suspend-then-hibernate";
      HandleLidSwitchExternalPower = "lock";
      # Inactivity trigger: suspend, then hibernate after HibernateDelaySec
      IdleAction = "suspend-then-hibernate";
      IdleActionSec = "900";
    };
  };

  systemd.sleep.settings = {
    Sleep = {
      # Hibernate 10 minutes after entering suspend (s2idle drains battery)
      HibernateDelaySec = "600";
    };
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


