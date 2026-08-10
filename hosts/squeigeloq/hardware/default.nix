{ config, pkgs, ... }:

{
  imports = [
    ./squeigeloq.nix
    ./nvidialoq.nix
  ];
}
