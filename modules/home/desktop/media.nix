{ config, lib, pkgs, ... }:

{
  # Media applications
  home.packages = with pkgs; [
    spotify
    ncspot
    zathura
    pinta
  ];
}
