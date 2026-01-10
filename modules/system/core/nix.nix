{ config, lib, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Package overlays
  nixpkgs.overlays = [
    (final: prev: {
      qutebrowser = prev.qutebrowser.override { enableWideVine = true; };
    })
  ];

  # Chromium WideVine support
  nixpkgs.config.chromium.enableWideVine = true;

  # Enable experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
