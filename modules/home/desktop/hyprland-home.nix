{ lib, ... }:

{
  imports = [
    ./hyprland/settings.nix
    ./hyprland/bindings.nix
    ./hyprland/session.nix
  ];

  options.desktop.wallpaper.path = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = null;
    description = "Wallpaper image path, read at runtime by awww.";
  };

  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      configType = "lua";
      # NixOS owns the compositor and portal packages.
      package = null;
      portalPackage = null;
      systemd.enable = true;

      # Applies to displays without an explicit host rule.
      settings.monitor = [{
        output = "";
        mode = "preferred";
        position = "auto";
        scale = "auto";
      }];
    };
  };
}
