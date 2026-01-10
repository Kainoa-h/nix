{ config, lib, pkgs, ... }:

{
  # Full profile - everything including desktop apps
  # Gaming is enabled at the system level, not here
  imports = [
    ./desktop-user.nix
  ];
}
