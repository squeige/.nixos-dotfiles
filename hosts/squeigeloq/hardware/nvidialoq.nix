{ config, pkgs, lib, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Needed for Steam, 32-bit apps, and full driver coverage

    extraPackages = with pkgs; [
      nvidia-vaapi-driver # Enables VA-API hardware video acceleration for Firefox
      libvdpau-va-gl
    ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    # 595+ on the open kernel modules handles suspend/hibernate (including
    # suspend-then-hibernate) via in-kernel suspend notifiers. The old
    # nvidia-sleep.sh /proc interface was deprecated upstream and failed both
    # ways on this machine (Aug 2026): -5 EIO loop on suspend-then-hibernate
    # (nixpkgs#440422 gap) and an intermittent hard hang on plain suspend.
    # kernelSuspendNotifier is the default for open+595; set explicitly for clarity.
    powerManagement.enable = true;
    powerManagement.kernelSuspendNotifier = true;
    powerManagement.finegrained = false;
    # Open kernel modules (GA107 is supported). They require GSP firmware, so the
    # old NVreg_EnableGpuFirmware=0 workaround (for the 570-era Xid 119 resume
    # timeout) is gone — if Xid 119 reappears on resume, revert this to false.
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  boot.extraModprobeConfig = ''
    # VRAM backing store for hibernate; NVIDIA recommends non-tmpfs (/var/tmp is btrfs)
    options nvidia NVreg_TemporaryFilePath=/var/tmp
    options nvidia NVreg_EnableS0ixPowerManagement=1
    options nvidia NVreg_EnableMSI=1
  '';

  boot.kernelParams = [
    # nvme_core.default_ps_max_latency_us=0: LOQ s2idle fix (CachyOS) - NVMe low-power
    # state breaks resume on this machine family.
    "nvme_core.default_ps_max_latency_us=0"
    "pcie_aspm=off"
    "acpi_enforce_resources=lax"
    "ec_no_wakeup=1"
    "amd_iommu=pt"
  ];

  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    
    # Enables hardware video decoding in Firefox via VA-API
    NVD_BACKEND = "direct";
    MOZ_ENABLE_WAYLAND = "1";
  };
}
