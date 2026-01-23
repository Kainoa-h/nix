{ config, lib, pkgs, ... }:

{
  # Clipboard history service
  services.cliphist = {
    enable = true;
    allowImages = true;
  };

  # Desktop utility packages
  home.packages = with pkgs; [
    # Screenshot and display tools
    grim
    slurp

    # File system utilities
    udiskie

    # Office and productivity
    libreoffice-fresh
    hunspell

    # Development and AI tools
    # gemini-cli-bin
    # claude-code
  ];
}
