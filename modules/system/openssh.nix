{ config, pkgs, ... }:

{
  # Enable the OpenSSH daemon
  services.openssh = {
    enable = true;

    # Listen on port 5550 instead of the default 22.
    # openFirewall (default true) opens exactly these ports, so 22 stays closed.
    ports = [ 5550 ];

    settings = {
      # Disable root login over SSH for security
      PermitRootLogin = "no";

      # Optionally disable password authentication if using SSH keys exclusively
      # PasswordAuthentication = false;
    };
  };
}
