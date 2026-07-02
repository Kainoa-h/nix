{ inputs, config, pkgs, lib, ... }:

{
  # Import full profile (desktop user with all features)
  imports = [
    inputs.walker.homeManagerModules.default
    ../../modules/home/profiles/full.nix
  ];

  # Home Manager basic settings
  home.username = "kai";
  home.homeDirectory = "/home/kai";
  home.stateVersion = "25.11";

  # cursor
  home.file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
}
