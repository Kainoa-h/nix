{ inputs, config, pkgs, lib, ... }:

{
  # Import full profile (desktop user with all features)
  imports = [
    ../../modules/home/profiles/developer.nix
    ../../modules/home/profiles/base.nix
  ];

  # Home Manager basic settings
  home.username = "kai";
  home.homeDirectory = "/home/kai";
  home.stateVersion = "26.05";

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  xdg.enable = true;
}
