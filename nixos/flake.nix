{
    description = "test flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-23.11";
        nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
        hyprland.url = "github:hyprwm/Hyprland";
    };

    outputs = { self, nixpkgs, ... } @ inputs:
        let 
            inherit (self) outputs;
            lib = nixpkgs.lib;
        in {
        nixosConfigurations.qyuuron = lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs outputs; };
            modules = [ ./configuration.nix ];
        };
        overlays = import ./overlays.nix { inherit inputs; };
    };
}
