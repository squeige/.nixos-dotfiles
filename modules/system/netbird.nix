{ pkgs, ... }:

{
  # NetBird VPN daemon (system service, root tunnel)
  services.netbird.enable = true;
}