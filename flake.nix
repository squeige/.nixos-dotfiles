{ 
    description = "Initial nixos install squeigeloq";
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-26.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
       
        zen-browser = {
            url = "github:youwen5/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ...} @inputs: {
        nixosConfigurations.squeigeloq = nixpkgs.lib.nixosSystem {
            modules = [
                home-manager.nixosModules.home-manager
                ./hosts/squeigeloq/configuration.nix
                ./modules/hardware/squeigeloq.nix
                ./modules/hardware/nvidialoq.nix
                    {
                     home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        users.luigi = import ./home.nix;
                        backupFileExtension = "backup";
                        extraSpecialArgs = { inherit inputs; };
                     };
                 }
            ];
       };
       
    };
}
