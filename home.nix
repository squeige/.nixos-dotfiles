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
    
    xdg.configFile."nvim".source = ./config/nvim;
    
    home.packages = with pkgs; [
        wezterm
        keepassxc
        neovim
        opencode
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  }

