{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Sets 'bindkey -v'
    defaultKeymap = "viins";

    sessionVariables = {
      EDITOR = "nvim";
    };

    shellAliases = {
      # Standard Aliases
      zo = "zoxide";
      ll = "eza -laBhHF";
      lg = "eza -laBhHF --git-repos --git --no-permissions";
      v = "nvim";
      y = "yazi";
      h = "z ~";
      cd = "z";

      # Safety
      rm = "trash";

      # Navigation
      config = "z $HOME/.config; v .; z -";

      # Platform-specific clipboard
      cb = if pkgs.stdenv.isLinux
           then "wl-copy -selection clipboard"
           else "pbcopy";

      # Platform-specific rebuild
      nrs = if pkgs.stdenv.isLinux
            then "nixos-rebuild switch --flake $HOME/nixos-config#nix-muffin --sudo"
            else "sudo darwin-rebuild switch --flake .#macbook";
    };

    # Complex Functions & Custom Logic
    initContent = ''
      ${lib.optionalString pkgs.stdenv.isDarwin ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
        alias kan="sudo kanata --port 1012 --cfg ~/nixos-config/kanata/kanata_mod.kbd > /dev/null"
      ''}

      # Load external alias files
      ${builtins.readFile ../../../zsh/git_alias.zsh}
      ${builtins.readFile ../../../zsh/tmux_alias.zsh}
      ${builtins.readFile ../../../zsh/docker_alias.zsh}

      ${lib.optionalString pkgs.stdenv.isLinux ''
        export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock
        export DOCKER_sock=/run/user/$UID/podman/podman.sock

        alias opr='export OPENROUTER_API_KEY=$(pass llm/openrouter); export ANTHROPIC_AUTH_TOKEN="$OPENROUTER_API_KEY"'
        export ANTHROPIC_BASE_URL="https://openrouter.ai/api"
        export ANTHROPIC_API_KEY="" # Important: Must be explicitly empty
      ''}

      # --- Functions ---

      expand-all-aliases-n-functions() {
        local last_word="''${LBUFFER##* }"
        local before_last="''${LBUFFER%$last_word}"
        # Check if it's an alias
        local expanded
        expanded="$(alias "$last_word" 2>/dev/null | cut -d'=' -f2 | sed "s/^'//; s/'$//")"

        if [[ -n "$expanded" ]]; then
          LBUFFER="''${before_last}''${expanded}"
          return
        fi

        expanded="$(declare -f $last_word)"

        if [[ -n "$expanded" ]]; then
          echo "$expanded" | bat
        fi
      }

      hcb() {
        fc -l 1 | fzf | awk '{$1=""; sub(/^ /,""); print}' | cb
      }

      clean_code() {
        echo "🔍 Searching for build artifacts to delete..."
        echo ""

        local folders=(node_modules build dist .next target out .terraform .python_packages .venv venv)

        for folder in $folders; do
          while IFS= read -r dir; do
            if [[ -d "$dir" ]]; then
              size=$(du -sh "$dir" 2>/dev/null | cut -f1)
              echo "Found: $dir ($size)"
            fi
          done < <(find . -name "$folder" -type d -prune 2>/dev/null)
        done

        echo ""
        echo -n "⚠️  Delete all these folders? (y/N): "
        read response

        if [[ "$response" =~ ^[Yy]$ ]]; then
          echo ""
          echo "🗑️  Deleting..."
          for folder in $folders; do
            find . -name "$folder" -type d -prune -exec rm -rf '{}' + 2>/dev/null
          done
          echo "✅ Done! Run 'du -sh .' to see your new folder size."
        else
          echo "❌ Cancelled."
        fi
      }

      # --- Bindings ---
      zle -N expand-all-aliases-n-functions
      bindkey '^@' expand-all-aliases-n-functions  # Ctrl-Space

      # --- Completion Styling ---
      zstyle ':completion:*' menu select
    '';
  };
}
