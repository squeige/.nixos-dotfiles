{ pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  # 1. Disable standard systemd-boot so Lanzaboote can take over
  boot.loader.systemd-boot.enable = lib.mkForce false;

  # 2. Enable Lanzaboote
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  # 3. Ensure sbctl is available in the system environment for key management
  environment.systemPackages = with pkgs; [
    sbctl
  ];

  # 4. Optional: keep EFI variables writeable for sbctl enrollments
  boot.loader.efi.canTouchEfiVariables = true;
}
