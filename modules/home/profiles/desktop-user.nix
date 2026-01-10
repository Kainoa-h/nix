{ config, lib, pkgs, ... }:

{
  # Desktop user profile - developer + desktop applications
  imports = [
    ./developer.nix
    ../desktop/terminal.nix
    ../desktop/hyprland-home.nix
    ../desktop/waybar.nix
    ../desktop/browsers.nix
    ../desktop/launchers.nix
    ../desktop/file-managers.nix
    ../desktop/communication.nix
    ../desktop/media.nix
    ../desktop/utilities.nix
  ];
}
