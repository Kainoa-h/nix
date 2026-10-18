{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    env = [
      { _args = [ "XCURSOR_SIZE" "24" ]; }
      { _args = [ "HYPRCURSOR_SIZE" "24" ]; }
    ];

    config = {
      general = {
        gaps_in = 3;
        gaps_out = { top = 7; right = 7; bottom = 7; left = 7; };
        border_size = 1;
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
        col = {
          active_border = {
            colors = [ "rgba(33ccffee)" "rgba(00ff99ee)" ];
            angle = 45;
          };
          inactive_border = "rgba(595959aa)";
        };
      };

      layout.single_window_aspect_ratio = "4 3";
      decoration = {
        rounding = 10;
        rounding_power = 2;
        active_opacity = 1;
        inactive_opacity = 0.6;
        shadow.enabled = false;
        blur.enabled = false;
      };
      animations.enabled = false;
      dwindle.preserve_split = true;
      master.new_status = "master";
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
          tap_to_click = false;
        };
      };
    };

    workspace_rule = [{
      workspace = "special:magic";
      gaps_out = { top = 30; right = 150; bottom = 30; left = 150; };
    }];
  };
}
