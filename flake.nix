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

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, herdr-src, ... } @inputs:
  let
    system = "x86_64-linux";
    # Pull the pre-built package directly from herdr's flake
    herdr = herdr-src.packages.${system}.default;
  in
  {
    nixosConfigurations.squeigeloq = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs herdr; };
      modules = [
        home-manager.nixosModules.home-manager
        ./hosts/squeigeloq/configuration.nix
        ./modules/hardware/squeigeloq.nix
        ./modules/hardware/nvidialoq.nix
        ./modules/hardware/audio.nix
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.luigi = import ./home.nix;
            backupFileExtension = "backup";
            extraSpecialArgs = { inherit inputs herdr; };
          };
        }
      ];
    };
  };
}
