{ 
    description = "Initial nixos install squeigeloq";
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-26.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ...}: {
        nixosConfigurations.squeigeloq = nixpkgs.lib.nixosSystem {
            modules = [
                home-manager.nixosModules.home-manager
                ./hosts/squeigeloq/configuration.nix
                    {
                     home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        users.luigi = import ./home.nix;
                        backupFileExtension = "backup";
                     };
                 }
            ];
       };
    };
}
