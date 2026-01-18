{ config, lib, pkgs, ... }:

{
  # SketchyBar packages (macOS only)
  home.packages = lib.optionals pkgs.stdenv.isDarwin (with pkgs; [
    sbarlua
    sketchybar-app-font
  ]);

  # SketchyBar configuration with Lua support
  programs.sketchybar = lib.mkIf pkgs.stdenv.isDarwin {
    enable = true;
    package = pkgs.sketchybar;
    extraPackages = [ 
    pkgs.jq
    pkgs.lua5_4
    ];
  };


  home.sessionVariables = lib.mkIf pkgs.stdenv.isDarwin {
      LUA_CPATH = "${pkgs.sbarlua}/lib/lua/5.4/?.so;;";
      LUA_PATH = "${pkgs.sbarlua}/share/lua/5.4/?.lua;;";
  };

  # Symlink entire SketchyBar config directory
  xdg.configFile."sketchybar" = lib.mkIf pkgs.stdenv.isDarwin {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/sketchybar";
  };

  home.file.".local/share/sketchybar_lua/sketchybar.so" = lib.mkIf pkgs.stdenv.isDarwin {
      source = "${pkgs.sbarlua}/lib/lua/5.4/sketchybar.so";
  };
}
