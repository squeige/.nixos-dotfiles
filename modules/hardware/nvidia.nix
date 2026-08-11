{ config, lib, pkgs, ... }:

{
  # Enable OpenGL / Graphics
  hardware.graphics = {
    enable = true;
  };

  # Load NVIDIA driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Modesetting is required for almost all setups nowadays
    modesetting.enable = true;

    # Power management (optional for desktops, but good to keep default/false unless troubleshooting sleep issues)
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    # Use the proprietary NVIDIA open kernel modules (recommended for Turing/Ampere/Ada Lovelace cards like the RTX 3050)
    # Set this to false if you prefer the classic closed-source blob driver
    open = true;

    # Enable the NVIDIA settings menu (accessible via nvidia-settings)
    nvidiaSettings = true;

    # Select the stable driver package matching your kernel
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
