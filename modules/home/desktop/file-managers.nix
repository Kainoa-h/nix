{ config, lib, pkgs, inputs, ... }:

{
  # Yazi file manager
  programs.yazi = {
    enable = true;
    plugins = {
      "relative-motions" = inputs.yazi-relative-motions;
      "starship" = inputs.yazi-starship;
    };
  };

  # Symlink to external Yazi configuration
  xdg.configFile = {
    "yazi/yazi.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/yazi/yazi.toml";
    "yazi/keymap.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/yazi/keymap.toml";
    "yazi/init.lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/yazi/init.lua";
    "yazi/theme.toml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/yazi/theme.toml";
  };

  # Nautilus file manager
  home.packages = lib.optionals pkgs.stdenv.isLinux (with pkgs; [
    nautilus
  ]);
}
