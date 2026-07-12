{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    zed-editor
  ];
}
