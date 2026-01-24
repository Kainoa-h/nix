{ config, lib, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Chromium WideVine support
  nixpkgs.config.chromium.enableWideVine = true;

  # Enable experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
