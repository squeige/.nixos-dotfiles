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
    # nvidia-suspend/resume scripts were previously disabled because they crashed the
    # GSP on resume; with NVreg_EnableGpuFirmware=0 (no GSP) they're safe and needed to
    # avoid "Flip event timeout" + DRM EPERM after s2idle resume on this dGPU-only
    # (Ryzen 7235HS) LOQ. NixOS adds NVreg_PreserveVideoMemoryAllocations=1 with this.
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false; # Proprietary driver is recommended for 30-series (Ampere) laptops/cards
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  boot.extraModprobeConfig = ''
    options nvidia NVreg_TemporaryFilePath=/dev/shm
    options nvidia NVreg_EnableS0ixPowerManagement=1
    options nvidia NVreg_EnableMSI=1
    # Disable GSP firmware: Xid 119 GSP-RPC-timeout-on-resume is a known 570+
    # driver bug on Ampere s2idle laptops. Falls back to in-kernel RM path.
    options nvidia NVreg_EnableGpuFirmware=0
  '';

  boot.kernelParams = [
    # fbdev=1 without nvidia-sleep.sh triggers "Flip event timeout" on suspend/resume
    # (NVIDIA changelog 550.67). Dropped; the VT/ly still works via the EFI framebuffer.
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
