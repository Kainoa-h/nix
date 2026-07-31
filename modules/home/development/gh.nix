{ config, lib, pkgs, ... }:

{
  # Github packages
  home.packages = with pkgs; [
    gh
    gh-dash
  ];
}
