{ config, lib, pkgs, ... }:

{
  # Font packages
  fonts.packages = with pkgs; [
    font-awesome
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    dina-font
    proggyfonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    nerd-fonts.caskaydia-cove
    corefonts
  ];

  # Font configuration
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      # The default font for most UI (menus, windows, firefox)
      sansSerif = [ "Noto Sans" "Noto Sans CJK JP" ];
      # The default font for "serif" text (often used in reading modes)
      serif = [ "Noto Serif" "Noto Serif CJK JP" ];
      # The default font for terminals and code editors
      monospace = [ "JetBrainsMono Nerd Font" "Noto Sans Mono CJK JP" ];
      # The default font for emojis
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
