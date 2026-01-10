{ config, lib, pkgs, ... }:

{
  # Web browsers
  home.packages = with pkgs; [
    chromium
    qutebrowser
  ];
}
