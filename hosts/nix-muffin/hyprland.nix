{ lib, pkgs, ... }:

let
  inherit (import ../../modules/home/desktop/hyprland/bindings-lib.nix { inherit lib; }) bind exec;
in
{
  home.packages = [ pkgs.brightnessctl ];

  wayland.windowManager.hyprland.settings = {
    monitor = [
      {
        output = "DP-2";
        mode = "1920x1080@144";
        position = "1080x0";
        scale = 1;
      }
      {
        output = "HDMI-A-1";
        mode = "1920x1080@60";
        position = "0x0";
        scale = 1;
        transform = 1;
      }
    ];

    # The NixOS DDC service exposes external monitors as backlight devices.
    bind = [
      (bind "XF86MonBrightnessUp" (exec "${pkgs.brightnessctl}/bin/brightnessctl -e4 set 5%+") { locked = true; })
      (bind "XF86MonBrightnessDown" (exec "${pkgs.brightnessctl}/bin/brightnessctl -e4 -n1 set 5%-") { locked = true; })
    ];
  };
}
