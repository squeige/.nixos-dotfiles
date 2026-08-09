# incus.nix
{ config, pkgs, ... }:

{
  # Enable the Incus service
  virtualisation.incus.enable = true;

  # 1. Enable nftables (Required by Incus for networking)
  networking.nftables.enable = true;

  # Enable IP forwarding for bridge networking
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  # Add your username to the incus-admin group
  users.users.luigi.extraGroups = [ "incus-admin" ];

  # Optional: Preseed network/storage setup
  virtualisation.incus.preseed = {
    networks = [
      {
        name = "incusbr0";
        type = "bridge";
        config = {
          "ipv4.address" = "10.0.100.1/24";
          "ipv4.nat" = "true";
        };
      }
    ];
    profiles = [
      {
        name = "default";
        devices = {
          eth0 = {
            name = "eth0";
            network = "incusbr0";
            type = "nic";
          };
          root = {
            path = "/";
            pool = "default";
            type = "disk";
          };
        };
      }
    ];
    storage_pools = [
      {
        name = "default";
        driver = "btrfs";
        config = {
          source = "/var/lib/incus/storage-pools/default";
        };
      }
    ];
  };
}
