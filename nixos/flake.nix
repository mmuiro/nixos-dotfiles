{
    description = "NixOS Overall Config";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-23.11";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        hyprland.url = "github:hyprwm/Hyprland";
        wired-notify.url = "github:Toqozz/wired-notify";
        home-manager = {
            url = "github:nix-community/home-manager/release-23.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, wired-notify, home-manager, ... } @ inputs:
        let 
            inherit (self) outputs;
            system = "x86_64-linux";
            lib = nixpkgs.lib;
        in {
        nixosConfigurations.qyuuron = lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs outputs; };
            modules = [ 
                ./configuration.nix
                home-manager.nixosModules.home-manager {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.jzli = import ./home.nix;
                }
            ];
        };
        overlays = import ./overlays.nix { inherit inputs; };
    };
}
