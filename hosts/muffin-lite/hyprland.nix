{ lib, pkgs, ... }:

let
  inherit (import ../../modules/home/desktop/hyprland/bindings-lib.nix { inherit lib; }) bind exec;
in
{
  home.packages = [ pkgs.brightnessctl ];

  wayland.windowManager.hyprland.settings = {
    monitor = [{
      output = "eDP-1";
      mode = "preferred";
      position = "auto";
      scale = 1;
    }];

    bind = [
      (bind "XF86MonBrightnessUp" (exec "${pkgs.brightnessctl}/bin/brightnessctl --device intel_backlight -e4 set 5%+") { locked = true; })
      (bind "XF86MonBrightnessDown" (exec "${pkgs.brightnessctl}/bin/brightnessctl --device intel_backlight -e4 -n1 set 5%-") { locked = true; })
    ];
  };
}
