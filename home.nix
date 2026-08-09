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
    
    
    home.packages = with pkgs; [
        pkgs.wezterm
        pkgs.keepassxc
        pkgs.neovim
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  }
