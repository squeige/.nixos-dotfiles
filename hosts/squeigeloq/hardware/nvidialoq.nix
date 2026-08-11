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
    # s2idle-only laptop: nvidia-suspend/resume scripts (S3-era) crash the GSP on
    # resume. Keep the GPU in D0 through suspend instead (NVreg_EnableS0ixPowerManagement=1).
    powerManagement.enable = false;
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
    "nvidia-drm.fbdev=1"
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
