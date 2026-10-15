{ config, lib, pkgs, ... }:

{
  home.packages = [ (pkgs.writeShellApplication {
    name = "kanata-waybar-state";
    runtimeInputs = [ pkgs.coreutils ];
    text = ''
      state="''${XDG_RUNTIME_DIR:?}/kanata-observer/state.json"
      if [[ -r "$state" ]]; then
        cat "$state"
      else
        printf '%s\n' '{"text":"","class":"unknown"}'
      fi
    '';
  }) ];

  # Symlink to external Waybar configuration
  xdg.configFile."waybar".source = config.lib.file.mkOutOfStoreSymlink "/home/kai/nixos-config/waybar";
}
