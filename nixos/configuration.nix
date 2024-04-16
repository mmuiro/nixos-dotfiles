# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, outputs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
            ./hardware-configuration.nix
        ];

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    # mute the ucsi_acpi module (for USB-C cards)
    boot.blacklistedKernelModules = [ "ucsi_acpi" ];


    networking.hostName = "qyuuron"; # Define your hostname.
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

    # Set your time zone.
    time.timeZone = "America/Los_Angeles";

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Select internationalisation properties.
    # i18n.defaultLocale = "en_US.UTF-8";
    # console = {
    #   font = "Lat2-Terminus16";
    #   keyMap = "us";
    #   useXkbConfig = true; # use xkb.options in tty.
    # };

    # Enable sound.
    sound.enable = true;
    hardware.pulseaudio.enable = true;
  
    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;
  
    users.users.jzli = {
        isNormalUser = true;
        uid = 1000;
        shell = pkgs.zsh;
        extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
        # other information is specified in home.nix
    };

    # Nixpkgs Config
    nixpkgs = {
        config = {
            allowUnfree = true;
        };
        overlays = [ outputs.overlays.unstable-packages ];
    };

    # Package List (via environment)
    environment.systemPackages = with pkgs; [
        # UTILS
        vim
        neovim
        wget
        chromium
        wezterm
        xdg-utils
        rofi-wayland
        libnotify
        unzip
        du-dust
        ripgrep
        fd
        brightnessctl
        acpi
        socat
        jq
        cinnamon.nemo
        inotify-tools
        wl-clipboard
        exfat
        # Programming languages (switch to using shell.nix where possible)
        rustup
        go
        python3
        nodejs_21
        # SNS
        discord
        slack
        # RICING
        hyprpaper
        unstable.eww
        nwg-look
        # TODO: add nwg-look (lxappearance alternative)
        # OTHER
        neofetch
        # Additional packages defined in flake.nix not found in nixpkgs
        inputs.wired-notify.packages.${pkgs.system}.default
    ];

    # Package List (via enable)
    programs = {
        hyprland = {
            enable = true;
            package = inputs.hyprland.packages.${pkgs.system}.hyprland;
            xwayland.enable = true;
        };
        git = {
            enable = true;
            config.user = {
                user.name = "mmuiro";
                user.email = "joeyzhuoyili@gmail.com";
            };
        };
        zsh = {
            enable = true;
        };
    };

    services = {
        greetd = {
            enable = true;
            settings = {
                default_session = {
                    command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'dbus-run-session Hyprland'";
                    user = "greeter";
                };
            };
        };
        mullvad-vpn = {
           package = pkgs.unstable.mullvad-vpn;
           enable = true;
        };
        automatic-timezoned.enable = true;
        power-profiles-daemon.enable = true;
        devmon.enable = true;
        gvfs.enable = true;
        udisks2.enable = true;
        auto-cpufreq = {
            enable = true;
        };
        thermald = {
            enable = true;
        };
    };

    xdg = {
        autostart.enable = true;
        portal = {
            enable = true;
            extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
        };
        mime.enable = true;
    };

    # Extra Fonts
    fonts.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];

    system.stateVersion = "23.11"; # Don't delete or modify this, won't update the system.
  
    # Additional Settings
    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ]; 
        substituters = [ 
            "https://hyprland.cachix.org" 
            "https://anyrun.cachix.org"
        ];
        trusted-public-keys = [
            "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
            "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
        ];
    };
    # garbage collector
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d";
    };
}

