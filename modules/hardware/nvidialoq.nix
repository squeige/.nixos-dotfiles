{ config, pkgs, lib, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false; 
    open = false; 
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  boot.extraModprobeConfig = ''
    options nvidia NVreg_TemporaryFilePath=/dev/shm
    options nvidia NVreg_EnableS0ixPowerManagement=1
    options nvidia NVreg_EnableMSI=1
  '';

  boot.kernelParams = [
    "nvidia-drm.fbdev=1"
    "pcie_aspm=off"               
    "acpi_enforce_resources=lax"  
    "ec_no_wakeup=1"              
    "amd_iommu=pt"                # Keeps IOMMU enabled for VMs, but fixes the GPU wake-up mapping bug
  ];

  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ]; 

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
  };
}


