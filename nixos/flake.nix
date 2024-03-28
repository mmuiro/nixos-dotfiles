{
    description = "test flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-23.11";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        hyprland.url = "github:hyprwm/Hyprland";
        wired-notify.url = "github:Toqozz/wired-notify";
    };

    outputs = { self, nixpkgs, wired-notify, ... } @ inputs:
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
            ];
        };
        overlays = import ./overlays.nix { inherit inputs; };
    };
}
