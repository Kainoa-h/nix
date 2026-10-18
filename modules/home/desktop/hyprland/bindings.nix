{ config, lib, pkgs, ... }:

let
  inherit (import ./bindings-lib.nix { inherit lib; }) bind dispatch exec;
  mainMod = "ALT";
  walker = lib.getExe config.programs.walker.package;

  screenshotFull = pkgs.writeShellApplication {
    name = "screenshot-full";
    runtimeInputs = [ pkgs.grim pkgs.wl-clipboard ];
    text = ''
      grim - | wl-copy
    '';
  };
  screenshotArea = pkgs.writeShellApplication {
    name = "screenshot-area";
    runtimeInputs = [ pkgs.grim pkgs.slurp pkgs.wl-clipboard ];
    text = ''
      geometry="$(slurp -d)"
      grim -g "$geometry" - | wl-copy
    '';
  };

  numberedWorkspaces = map (number: {
    key = if number == 10 then "0" else toString number;
    workspace = number;
  }) (lib.range 1 10);
  namedWorkspaces = map (key: { inherit key; workspace = "name:${key}"; }) [
    "A" "B" "C" "D" "E" "F" "G" "I" "M" "N" "O" "P" "Q" "R" "T" "U" "V" "W" "Y" "X" "Z"
  ];
  workspaceBinds = lib.concatMap (entry: [
    (bind "${mainMod} + ${entry.key}" (dispatch "focus" [{ inherit (entry) workspace; }]) { })
    (bind "${mainMod} + SHIFT + ${entry.key}" (dispatch "window.move" [{ inherit (entry) workspace; }]) { })
  ]) (numberedWorkspaces ++ namedWorkspaces);
  directionBinds = lib.concatMap (entry: [
    (bind "${mainMod} + ${entry.key}" (dispatch "focus" [{ direction = entry.focus; }]) { })
    (bind "${mainMod} + SHIFT + ${entry.key}" (dispatch "window.move" [{ direction = entry.move; }]) { })
  ]) [
    { key = "H"; focus = "left"; move = "l"; }
    { key = "L"; focus = "right"; move = "r"; }
    { key = "K"; focus = "up"; move = "u"; }
    { key = "J"; focus = "down"; move = "d"; }
  ];
in
{
  wayland.windowManager.hyprland.settings.bind = [
    (bind "SUPER + V" (exec "${walker} --provider clipboard") { })
    (bind "SUPER + ALT + SHIFT + S" (exec (lib.getExe screenshotFull)) { })
    (bind "SUPER + SHIFT + S" (exec (lib.getExe screenshotArea)) { })
    (bind "${mainMod} + SUPER + P" (exec "${pkgs.ghostty}/bin/ghostty") { })
    (bind "${mainMod} + SUPER + Q" (dispatch "window.close" [ ]) { })
    (bind "${mainMod} + SUPER + M" (dispatch "exit" [ ]) { })
    (bind "${mainMod} + SUPER + E" (exec "${pkgs.kdePackages.dolphin}/bin/dolphin") { })
    (bind "${mainMod} + SUPER + V" (dispatch "window.float" [ ]) { })
    (bind "${mainMod} + SPACE" (exec walker) { })
    (bind "${mainMod} + equal" (dispatch "layout" [ "splitratio 0.05" ]) { })
    (bind "${mainMod} + minus" (dispatch "layout" [ "splitratio -0.05" ]) { })
    (bind "${mainMod} + comma" (dispatch "layout" [ "togglesplit" ]) { })
    (bind "${mainMod} + SUPER + F" (dispatch "window.fullscreen" [ ]) { })
    (bind "SUPER + mouse:272" (dispatch "window.drag" [ ]) { mouse = true; })
    (bind "SUPER + mouse:273" (dispatch "window.resize" [ ]) { mouse = true; })
    (bind "${mainMod} + S" (dispatch "workspace.toggle_special" [ "magic" ]) { })
    (bind "${mainMod} + SHIFT + S" (dispatch "window.move" [{ workspace = "special:magic"; }]) { })
    (bind "${mainMod} + mouse_down" (dispatch "focus" [{ workspace = "e+1"; }]) { })
    (bind "${mainMod} + mouse_up" (dispatch "focus" [{ workspace = "e-1"; }]) { })
    (bind "${mainMod} + mouse:272" (dispatch "window.drag" [ ]) { mouse = true; })
    (bind "${mainMod} + mouse:273" (dispatch "window.resize" [ ]) { mouse = true; })
    (bind "XF86AudioRaiseVolume" (exec "${pkgs.wireplumber}/bin/wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+") { locked = true; })
    (bind "XF86AudioLowerVolume" (exec "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-") { locked = true; })
    (bind "XF86AudioMute" (exec "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") { locked = true; })
    (bind "XF86AudioMicMute" (exec "${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle") { locked = true; })
    (bind "XF86AudioNext" (exec "${pkgs.playerctl}/bin/playerctl next") { locked = true; })
    (bind "XF86AudioPause" (exec "${pkgs.playerctl}/bin/playerctl play-pause") { locked = true; })
    (bind "XF86AudioPlay" (exec "${pkgs.playerctl}/bin/playerctl play-pause") { locked = true; })
    (bind "XF86AudioPrev" (exec "${pkgs.playerctl}/bin/playerctl previous") { locked = true; })
  ] ++ directionBinds ++ workspaceBinds;
}
