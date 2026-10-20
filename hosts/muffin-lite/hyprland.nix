{ lib, pkgs, ... }:

let
  inherit (import ../../modules/home/desktop/hyprland/bindings-lib.nix { inherit lib; }) bind exec;
in
{
  home.packages = [ pkgs.brightnessctl ];

  wayland.windowManager.hyprland.settings = {
    monitor = [
      {
        output = "eDP-1";
        mode = "preferred";
        position = "0x0";
        scale = 1;
      }
      {
        output = "DP-1";
        mode = "1920x1080@60";
        position = "1920x0";
        scale = 1;
      }
    ];

    # Map the USB touchscreen to the external display.
    config.input.touchdevice = {
      enabled = true;
      output = "DP-1";
    };

    bind = [
      (bind "XF86MonBrightnessUp" (exec "${pkgs.brightnessctl}/bin/brightnessctl --device intel_backlight -e4 set 5%+") { locked = true; })
      (bind "XF86MonBrightnessDown" (exec "${pkgs.brightnessctl}/bin/brightnessctl --device intel_backlight -e4 -n1 set 5%-") { locked = true; })
    ];
  };
}
