{ config, lib, pkgs, ... }:

{
  # Symlink to external Hyprland configuration
  xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink "/home/kai/nixos-config/hypr";
}
