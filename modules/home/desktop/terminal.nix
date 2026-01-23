{ config, lib, pkgs, ... }:

{
  # Ghostty terminal packages (Linux only - use Homebrew on macOS)
  home.packages = lib.optionals pkgs.stdenv.isLinux (with pkgs; [
    ghostty
  ]);

  # Ghostty terminal configuration (Linux only - Homebrew version on macOS doesn't use this)
  programs.ghostty = lib.mkIf pkgs.stdenv.isLinux {
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

  # Ghostty config file for macOS (Homebrew version reads from XDG config)
  xdg.configFile."ghostty/config" = lib.mkIf pkgs.stdenv.isDarwin {
    text = ''
      background = 002b36
      foreground = ffffff
      background-opacity = 0.8

      font-family = CaskaydiaCove Nerd Font
      font-size = 15
      font-feature = +liga

      macos-titlebar-style = hidden

      mouse-hide-while-typing = true

      keybind = global:ctrl+p=toggle_quick_terminal
      keybind = super+s>super+s=text::w\n
      keybind = all:alt+cmd+down=scroll_page_lines:25
      keybind = all:alt+cmd+up=scroll_page_lines:-25
      keybind = shift+enter=text:\x1b\r
    '';
  };

  # Set as default terminal
  home.sessionVariables = {
    TERMINAL = "ghostty";
  };
}
