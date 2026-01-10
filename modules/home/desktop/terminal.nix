{ config, lib, pkgs, ... }:

{
  # Ghostty terminal packages
  home.packages = with pkgs; [
    ghostty
  ];

  # Ghostty terminal configuration
  programs.ghostty = {
    enable = true;

    enableZshIntegration = true;

    settings = {
      background = "002b36";
      foreground = "ffffff";
      background-opacity = 0.8;

      font-family = "CaskaydiaCove Nerd Font";
      font-size = 15;
      font-feature = "+liga";

      mouse-hide-while-typing = true;

      keybind = [
        "global:ctrl+p=toggle_quick_terminal"
        "super+s>super+s=text::w\\n"              # Double backslash for \n
        "all:alt+cmd+down=scroll_page_lines:25"
        "all:alt+cmd+up=scroll_page_lines:-25"
        "shift+enter=text:\\x1b\\r"               # Double backslash for hex codes
      ];
    };
  };

  # Set as default terminal
  home.sessionVariables = {
    TERMINAL = "ghostty";
  };
}
