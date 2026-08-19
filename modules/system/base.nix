{ pkgs, ... }:

{
  # Rescue / essential tools (keep minimal; user apps live in home-manager)
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
  ];

  nixpkgs.config.allowUnfree = true;

  # Zed downloads prebuilt dynamically-linked language servers (e.g.
  # package-version-server) that NixOS can't run without a stub loader.
  programs.nix-ld = {
    enable = true;
    libraries = [ pkgs.openssl ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "America/Costa_Rica";

  # Automatic garbage collection: monthly, keep 10 generations
  nix.gc = {
    automatic = true;
    dates = "monthly";
    options = "--delete-older-than 10";
  };
}
