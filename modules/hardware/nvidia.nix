{ config, lib, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    # Enable NVIDIA suspend/resume services so the GPU state is saved and restored.
    powerManagement.enable = true;
    powerManagement.finegrained = false;

    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Disable dithering — prevents red sparkle artifacts on the Huion pen display
  services.xserver.deviceSection = ''
    Option "FlatPanelProperties" "Dithering = Disabled"
  '';

  # Force Wayland/EGL to bind correctly to NVIDIA's GBM backend
  environment.sessionVariables = {
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
}
