{ config, lib, pkgs, inputs, ... }:

let
  sessionTarget = "hyprland-session.target";
  wallpaperPath = config.desktop.wallpaper.path;
  awww = inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww;
  startWallpaper = pkgs.writeShellApplication {
    name = "start-wallpaper";
    runtimeInputs = [ awww pkgs.coreutils ];
    text = ''
      for ((attempt = 0; attempt < 50; attempt++)); do
        if awww query >/dev/null 2>&1; then
          exec awww img ${lib.escapeShellArg wallpaperPath}
        fi
        sleep 0.5
      done

      echo "start-wallpaper: awww daemon did not become ready" >&2
      exit 1
    '';
  };
in
{
  wayland.systemd.target = sessionTarget;

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      targets = [ sessionTarget ];
    };
    # Settings/style remain in the existing out-of-store Waybar config.
  };

  services.udiskie = {
    enable = true;
    tray = "always";
  };
  systemd.user.services.udiskie = {
    Unit = {
      After = [ sessionTarget ];
      PartOf = [ sessionTarget ];
    };
    Install.WantedBy = lib.mkForce [ sessionTarget ];
  };

  home.packages = lib.mkIf (wallpaperPath != null) [ startWallpaper ];

  systemd.user.services.awww = lib.mkIf (wallpaperPath != null) {
    Unit = {
      Description = "Wayland wallpaper daemon";
      PartOf = [ sessionTarget ];
      After = [ sessionTarget ];
    };
    Service = {
      ExecStart = "${awww}/bin/awww-daemon";
      Restart = "on-failure";
      RestartSec = 1;
    };
    Install.WantedBy = [ sessionTarget ];
  };

  systemd.user.services.wallpaper = lib.mkIf (wallpaperPath != null) {
    Unit = {
      Description = "Apply the configured wallpaper";
      Requires = [ "awww.service" ];
      After = [ sessionTarget "awww.service" ];
      PartOf = [ sessionTarget "awww.service" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = lib.getExe startWallpaper;
      RemainAfterExit = true;
    };
    Install.WantedBy = [ sessionTarget ];
  };
}
