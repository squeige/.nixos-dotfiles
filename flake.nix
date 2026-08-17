{
  description = "NixOS Flake configuration for squeigedesk, squeigeloq, and vm01";

  inputs = {
    # Canonical github URL scheme
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Niri Flake Input
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      };

    herdr-src = {
      url = "github:herdrdev/herdr";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      # Stable tagged version instead of floating master branch
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {

      # Host 1: Laptop (Lenovo LOQ)
      squeigeloq = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/squeigeloq/configuration.nix
        ];
      };

      # Host 2: Hyper-V VM
      vm01 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/vm01/configuration.nix
        ];
      };

      # Host 3: Squeige Desktop
      squeigedesk = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/squeigedesk/configuration.nix
        ];
      };

    };
  };
}
