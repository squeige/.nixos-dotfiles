{ config, pkgs, ... }:

{
  imports = [
    ./power.nix
    ./nvidialoq.nix
  ];
}
