{ config, lib, pkgs, ... }:

{
  # Media applications
  home.packages = with pkgs; [
    ncspot
    zathura
    pinta
  ];
}
