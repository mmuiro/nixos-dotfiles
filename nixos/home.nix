{ config, pkgs, ... }:
{
    home.username = "jzli";
    home.homeDirectory = "/home/jzli";
    home.packages = with pkgs; [
        # nothing here yet...
    ];
    home.stateVersion = "23.11";
    programs.home-manager.enable = true;
}
