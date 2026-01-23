{ config, lib, pkgs, ... }:

{
  nix.enable = false;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
