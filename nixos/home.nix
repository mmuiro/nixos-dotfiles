{ config, pkgs, ... }:
{
    home.username = "jzli";
    home.homeDirectory = "/home/jzli";
    home.packages = with pkgs; [
        # nothing here yet...
    ];

    gtk = {
        enable = true;
        theme = {
            name = "Colloid-Dark";
            package = pkgs.colloid-gtk-theme;
        };
        cursorTheme = {
            name = "capitaine-cursors";
            package = pkgs.capitaine-cursors;
        };
        iconTheme = {
            name = "Reversal-purple-dark";
            package = (pkgs.reversal-icon-theme.override {
                allColorVariants = true;
            });
        };
    };
    
    # environment variables   
    home.sessionVariables = {
        GTK_THEME = "Colloid-Dark";
        XCURSOR_THEME = "capitain-cursors";
    };

    home.stateVersion = "23.11";
    programs.home-manager.enable = true;
}
