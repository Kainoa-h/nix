{ inputs, config, pkgs, lib, ... }:

{
  # Import base profile (shell + CLI tools)
  imports = [
    ../../modules/home/profiles/base.nix
  ];

  # User settings
  home.username = "kai";
  home.homeDirectory = "/Users/kai";
  home.stateVersion = "25.11";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}
