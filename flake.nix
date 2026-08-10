{
  description = "Initial nixos install squeigeloq";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    herdr-src = {
      url = "github:herdrdev/herdr";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, herdr-src, ... }@inputs:
  let
    system = "x86_64-linux";
    herdr = herdr-src.packages.${system}.default;
  in
  {
    nixosConfigurations = {

      # Host 1: Laptop
      squeigeloq = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs herdr; };
        modules = [
          ./hosts/squeigeloq/configuration.nix
        ];
      };

      # Host 2: Hyper-V VM
      vm01 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs herdr; };
        modules = [
          ./hosts/vm01/configuration.nix
        ];
      };

    };
  };
}
