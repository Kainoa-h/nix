{ inputs, config, pkgs, lib, ... }:

{
  # Import base profile (shell + CLI tools)
  imports = [
    ../../modules/home/profiles/base.nix
    ../../modules/home/profiles/developer.nix
    ../../modules/home/desktop/file-managers.nix
    ../../modules/home/desktop/terminal.nix
    ../../modules/home/desktop/sketchybar.nix
    ../../modules/home/desktop/communication.nix
    ../../modules/home/desktop/media.nix
    ../../modules/home/services/syncthing.nix
  ];

  # User settings
  home.username = "kai";
  home.homeDirectory = "/Users/kai";
  home.stateVersion = "26.05";

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  xdg.configFile."aerospace".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/aerospace";
}
