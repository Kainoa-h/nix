{ config, lib, pkgs, ... }:

let
  powerStatus = pkgs.writeShellScript "hyprlock-power-status" ''
    for supply in /sys/class/power_supply/*; do
      [[ -r "$supply/type" && -r "$supply/capacity" ]] || continue
      [[ $(< "$supply/type") == Battery ]] || continue

      capacity=$(< "$supply/capacity")
      status=$(< "$supply/status")
      case "$status" in
        Charging) printf ' · %s%%\n' "$capacity" ;;
        Full) printf ' · %s%%\n' "$capacity" ;;
        'Not charging') printf ' · %s%%\n' "$capacity" ;;
        *) printf '  · %s%%\n' "$capacity" ;;
      esac
      exit 0
    done

    printf 'AC power\n'
  '';
in
{
  options.desktop.lockscreen.backgroundPath = lib.mkOption {
    type = lib.types.str;
    description = "Background image path for Hyprlock, read at runtime.";
  };

  config = {
    programs.hyprlock = {
      enable = true;
      settings = {
        auth = {
          "pam:enabled" = true;
          "pam:module" = "hyprlock";
          "fingerprint:enabled" = false;
        };

        background = [{
          monitor = "";
          path = config.desktop.lockscreen.backgroundPath;
          color = "rgb(24, 24, 24)";
        }];

        input-field = [{
          monitor = "";
          size = "300, 60";
          position = "0, 15";
          halign = "center";
          valign = "bottom";
          fade_on_empty = false;
          inner_color = "rgba(24, 24, 24, 0.9)";
          outer_color = "rgb(180, 180, 180)";
          font_color = "rgb(240, 240, 240)";
          outline_thickness = 2;
          rounding = 12;
          placeholder_text = "Password...";
          fail_text = "oww!";
        }];

        label = [
          {
            monitor = "";
            text = "cmd[update:5000] ${powerStatus}";
            font_size = 14;
            color = "rgb(24, 24, 24)";
            position = "-20, 20";
            halign = "right";
            valign = "bottom";
          }
          {
            monitor = "";
            text = "$TIME";
            font_size = 64;
            color = "rgb(240, 240, 240)";
            position = "0, -15";
            halign = "center";
            valign = "top";
          }
          {
            monitor = "";
            text = ''cmd[update:1000] ${pkgs.coreutils}/bin/date +"%A, %d %B %Y"'';
            font_size = 18;
            color = "rgb(240, 240, 240)";
            position = "0, -110";
            halign = "center";
            valign = "top";
          }
        ];
      };
    };

    xdg.desktopEntries.lock-screen = {
      name = "Lock Screen";
      comment = "Lock the session with Hyprlock";
      exec = "${config.programs.hyprlock.package}/bin/hyprlock";
      icon = "system-lock-screen";
      terminal = false;
      categories = [ "System" ];
      settings.Keywords = "lock;screen;";
    };
  };
}
