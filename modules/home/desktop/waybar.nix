{ config, lib, pkgs, ... }:

{
  # Symlink to external Waybar configuration
  xdg.configFile."waybar".source = config.lib.file.mkOutOfStoreSymlink "/home/kai/nixos-config/waybar";
}
