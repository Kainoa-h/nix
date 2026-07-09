{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    # Basic Settings
    mouse = true;
    prefix = "C-b";
    terminal = "tmux-256color";
    baseIndex = 1;

    # Key Bindings & Plugin Settings
    extraConfig = ''
      set -g allow-passthrough on
      set -g status-position top
      set -g status-justify "absolute-centre"
      set -g set-clipboard on
      bind-key x kill-pane

      set-window-option -g mode-keys vi
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # Split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      unbind s
      bind-key "s" run-shell "sesh connect \"$(
        sesh list --icons | fzf-tmux -p 80%,70% \
          --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
          --header '  ^a ^t ^g ^x ^d kill ^f find' \
          --bind 'tab:down,btab:up' \
          --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
          --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t --icons)' \
          --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c --icons)' \
          --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z --icons)' \
          --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
          --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)' \
          --preview-window 'right:55%' \
          --preview 'sesh preview {}'
      )\""

      bind-key "W" run-shell "sesh window \"$(sesh window | fzf-tmux -p 60%,50% --prompt '🪟  ')\""
      bind g split-window -h -b -d "tail -f /dev/null" \; resize-pane -x 150
    '';

    # Plugins - ORDER MATTERS! (dracula must be last)
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      resurrect
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "mocha"
          set -g @catppuccin_window_status_style "none"
          set -g @catppuccin_status_background "none"

          set -g status-left-length 100
          set -g status-left "#{E:@catppuccin_status_session}"

          set -g status-right-length 100
          # set -g status-right "#{E:@catppuccin_status_application}"
          set -g status-right "#{E:@catppuccin_status_directory}"
          set -ag status-right "#{E:@catppuccin_status_uptime}"

          set -g @catppuccin_status_connect_separator "no"
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_right_separator " "

          set -g @catppuccin_directory_icon " "
          set -g @catppuccin_session_icon " "

          set -wg automatic-rename on
          set -g automatic-rename-format "Window"
          set -g window-status-format " #I#{?#{!=:#{window_name},Window},: #W,} "
          set -g window-status-style "bg=default,fg=#{@thm_sapphire},bold"
          set -g window-status-last-style "bg=default,fg=#{@thm_blue},bold"
          set -g window-status-activity-style "bg=#{@thm_red},fg=#{@thm_bg}"
          set -g window-status-bell-style "bg=#{@thm_red},fg=#{@thm_bg},bold"
          set -gF window-status-separator "#[bg=default,fg=#{@thm_overlay_0},bold]│"
          set -g window-status-current-format " #I#{?#{!=:#{window_name},Window},: #W,} "
          set -g window-status-current-style "bg=#{@thm_sky},fg=#{@thm_bg},bold"
        '';
      }
    ];
  };
}
