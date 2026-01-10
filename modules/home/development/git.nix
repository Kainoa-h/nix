{ config, lib, pkgs, ... }:

{
  # Git version control packages
  home.packages = with pkgs; [
    git
    lazygit
  ];
}
