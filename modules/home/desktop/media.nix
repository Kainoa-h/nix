{ config, lib, pkgs, ... }:

{
  # Media applications
  home.packages = with pkgs; [
    ncspot
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    # linux/wayland-specific tools
    zathura
    pinta
    vlc
  ];
}
