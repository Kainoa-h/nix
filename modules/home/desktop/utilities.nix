{ config, lib, pkgs, ... }:

{
  # Desktop utility packages
  home.packages = with pkgs; [
    # Screenshot and display tools
    grim
    slurp

    # File system utilities
    udiskie

    # Office and productivity
    # libreoffice-fresh
    hunspell

    # Bluetooth stuff
    bluez
    bluetui

    # PulseAudio controls
    pamix
  ];
}
