{ config, lib, pkgs, ... }:

{
  nix.enable = false;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable experimental features
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
      "https://numtide.cachix.org"
      "https://cache.numtide.com"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    ];
  };

  # Auto-optimize nix store
  # nix.optimise.automatic = true;

  # Garbage collection (weekly on Sunday)
#  nix.gc = {
#    automatic = true;
#    interval = { Weekday = 7; };
#    options = "--delete-older-than 30d";
#  };

  # Enable nix-daemon (required for multi-user nix on macOS)
  # services.nix-daemon.enable = false;

  # Add nixpkgs to NIX_PATH for legacy commands
  nix.nixPath = [ "nixpkgs=${pkgs.path}" ];
}
