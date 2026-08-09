{ config, pkgs, inputs, ... }:

{
    home.username = "luigi";
    home.homeDirectory = "/home/luigi";
    programs.git.enable = true;
    home.stateVersion = "26.05";
    
    programs.git = {
        userName = "luigi";
        userEmail = "virtual.employee@gmail.com";
    };
    
    home.packages = with pkgs; [
        wezterm
        keepassxc
        inputs.zen-browser.packages.${pkgs.system}.default
    ];
  }
