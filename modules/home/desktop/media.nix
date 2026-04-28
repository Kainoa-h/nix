{ config, lib, pkgs, ... }:

{
  # Media applications
  home.packages = with pkgs; [
    ncspot
    zathura
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    # linux/wayland-specific tools
    pinta
    vlc
  ];
}
