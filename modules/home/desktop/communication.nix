{ config, lib, pkgs, ... }:

{
  # Communication applications
  home.packages = with pkgs; [
    discord
    telegram-desktop
    thunderbird
  ];
}
