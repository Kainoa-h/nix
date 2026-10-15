{ inputs, pkgs, ... }:

let
  observer = inputs.kanata-layer-observer.packages.${pkgs.stdenv.hostPlatform.system}.default;
  callback = pkgs.writeShellApplication {
    name = "kanata-layer-change";
    runtimeInputs = [ pkgs.coreutils pkgs.jq pkgs.procps ];
    text = ''
      state_dir="''${XDG_RUNTIME_DIR:?}/kanata-observer"
      mkdir -p "$state_dir"
      layer="''${1-}"
      case "$layer" in
        main|symb|aux|fnc|normal) class="$layer" ;;
        'symb^') class=symb-shift ;;
        *) class=unknown ;;
      esac
      tmp=$(mktemp "$state_dir/state.XXXXXX")
      trap 'rm -f "$tmp"' EXIT
      jq -cn --arg text "$layer" --arg class "$class" \
        '{text: $text, class: $class}' > "$tmp"
      mv "$tmp" "$state_dir/state.json"
      # Nix's GTK wrapper runs Waybar as .waybar-wrapped.
      # Waybar may not be running yet.
      pkill -u "$(id -u)" -x -RTMIN+8 '(waybar|\.waybar-wrapped)' || true
    '';
  };
  observerConfig = (pkgs.formats.toml { }).generate "kanata-observer.toml" {
    port = 1012;
    script_path = "${callback}/bin/kanata-layer-change";
    log_level = "none";
    retry_seconds = 30;
  };
in
{
  home.packages = [ observer ];

  systemd.user.services.kanata-layer-observer = {
    Unit.Description = "Observe Kanata layers for Waybar";
    Service = {
      ExecStartPre = "${callback}/bin/kanata-layer-change";
      ExecStart = "${observer}/bin/kanata-layer-observer --config ${observerConfig}";
      Restart = "on-failure";
      RestartSec = 5;
      RuntimeDirectory = "kanata-observer";
      RuntimeDirectoryMode = "0700";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
