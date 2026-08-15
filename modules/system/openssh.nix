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

  # Add your desktop's public SSH key here to log in without a password
  users.users.luigi.openssh.authorizedKeys.keys = [
    # Replace this string with your desktop's actual SSH public key (~/.ssh/id_ed25519.pub)
    # "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI..."
  ];
}
