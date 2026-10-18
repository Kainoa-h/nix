{ config, lib, pkgs, inputs, ... }:

{
  options.desktop.wallpaper.path = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = null;
    description = "Wallpaper file to load with awww when Hyprland starts.";
  };

  config = {
    # Keep live editing while allowing generated configs alongside Hyprland's config.
    xdg.configFile."hypr/hyprland.lua".source = config.lib.file.mkOutOfStoreSymlink "/home/kai/nixos-config/hypr/hyprland.lua";

    home.file.".local/bin/start-wallpaper" = lib.mkIf (config.desktop.wallpaper.path != null) {
      executable = true;
      source = let
        awww = inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww;
      in pkgs.writeShellScript "start-wallpaper" ''
        set -eu

        if ! ${awww}/bin/awww query >/dev/null 2>&1; then
          ${awww}/bin/awww-daemon &
        fi

        for attempt in {1..50}; do
          if ${awww}/bin/awww query >/dev/null 2>&1; then
            exec ${awww}/bin/awww img ${lib.escapeShellArg config.desktop.wallpaper.path}
          fi
          ${pkgs.coreutils}/bin/sleep 0.5
        done

        echo "start-wallpaper: awww daemon did not become ready" >&2
        exit 1
      '';
    };
  };
}
