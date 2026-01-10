{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    # Basic Settings
    mouse = true;
    prefix = "C-a";
    terminal = "screen-256color";
    baseIndex = 1;

    # Key Bindings & Plugin Settings
    extraConfig = ''
      # Unbind default prefix
      unbind C-b
      bind-key C-a send-prefix

      # Split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      # Dracula theme configuration
      set -g @dracula-show-left-icon "#S"
      set -g @dracula-show-powerline true
      set -g @dracula-plugins "git tmux-ram-usage"
      set -g @dracula-git-disable-status false

      # Continuum auto-restore
      set -g @continuum-restore 'on'
    '';

    # Plugins - ORDER MATTERS! (dracula must be last)
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      resurrect
      continuum
      dracula  # MUST be last for theme to load properly
    ];
  };
}
