{ config, pkgs, inputs, ... }:

{
    home.username = "luigi";
    home.homeDirectory = "/home/luigi";
    home.stateVersion = "26.05";

    programs.git = {
        enable = true;
        settings = {
            user = {
                name = "luigi";
                email = "virtual.employee@gmail.com";
            };
        };
    };

    xdg.configFile."nvim".source = ../../config/nvim;

    home.packages = with pkgs; [
        # Terminals
        wezterm

        # Editors & dev tools
        neovim
        discord
        inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.opencode
        zed-editor
        ripgrep
        fd
        twitch
        unzip
        tree
        gcc
        gnumake

        # Apps
        keepassxc
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        inputs.herdr-src.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
}
