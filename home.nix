{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    inputs.walker.homeManagerModules.default
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kai";
  home.homeDirectory = "/home/kai";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.
  nixpkgs.config.allowUnfree = true;
  # The home.packages option allows you to install Nix packages into your
  # environment.
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      gcc
      gnumake
      tree-sitter
      ripgrep
      fd
    ];
  };

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/kai/nixos-config/nvim";
  xdg.configFile."hypr".source = config.lib.file.mkOutOfStoreSymlink "/home/kai/nixos-config/hypr";
  xdg.configFile."waybar".source = config.lib.file.mkOutOfStoreSymlink "/home/kai/nixos-config/waybar";
  programs.yazi = {
    enable = true;
    plugins = {
      "relative-motions" = inputs.yazi-relative-motions;
      "starship" = inputs.yazi-starship;
    };
  };

  xdg.configFile = {
    "yazi/yazi.toml".source = config.lib.file.mkOutOfStoreSymlink "/home/kai/nixos-config/yazi/yazi.toml";
    "yazi/keymap.toml".source = config.lib.file.mkOutOfStoreSymlink "/home/kai/nixos-config/yazi/keymap.toml";
    "yazi/init.lua".source = config.lib.file.mkOutOfStoreSymlink "/home/kai/nixos-config/yazi/init.lua";
    "yazi/theme.toml".source = config.lib.file.mkOutOfStoreSymlink "/home/kai/nixos-config/yazi/theme.toml";
  };

  programs.walker = {
    enable = true;
    runAsService = false;
  };

  # systemd.user.services.elephant = {
  #   Install.WantedBy = [ "graphical-session.target" ];
  # };

  home.packages = [
    inputs.elephant.packages.${pkgs.system}.default
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.chromium
    pkgs.nodejs
    pkgs.discord
    pkgs.trash-cli
    pkgs.bat
    pkgs.fzf
    pkgs.ghostty
    pkgs.wl-clipboard
    pkgs.libreoffice-fresh
    pkgs.hunspell
    pkgs.thunderbird
    pkgs.telegram-desktop
    pkgs.ncspot
    pkgs.tmux
    pkgs.spotify
    pkgs.btop
    pkgs.gemini-cli-bin
    pkgs.grim
    pkgs.slurp
    pkgs.gitleaks
    pkgs.opencode
    pkgs.claude-code
    pkgs.udiskie
    pkgs.nautilus
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kai/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  services.cliphist = {
    enable = true;
    allowImages = true; # optional, but recommended
  };

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

  home.sessionVariables = {
    TERMINAL = "ghostty";
  };

  programs.zoxide.enable = true;  # Replaces 'eval "$(zoxide init zsh)"'
  programs.pay-respects = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.fzf.enable = true;     # Ensures fzf is set up
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
      
      cb = "wl-copy -selection clipboard";

      nrs = "nixos-rebuild switch --flake $HOME/nixos-config#nix-muffin --sudo";
    };

    # 3. Complex Functions & Custom Logic
    initContent = ''
      # (Ideally, you should migrate these into 'shellAliases' eventually)
      ${builtins.readFile ./zsh/git_alias.zsh}
      ${builtins.readFile ./zsh/tmux_alias.zsh}
      ${builtins.readFile ./zsh/docker_alias.zsh}

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

  programs.eza = {
      enable = true;
      icons = "auto";
  };

  programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      
      # We use '' strings for multiline. 
      # Note: ''${...} is how we escape ${...} in Nix to keep it literal for Starship.
    format = lib.concatStrings [
        "[](color_orange)"
        "$directory"
        "[](fg:color_orange bg:color_aqua)"
        "$git_branch"
        "$git_status"
        "[](fg:color_aqua bg:color_blue)"
        "$c"
        "$cpp"
        "$rust"
        "$golang"
        "$nodejs"
        "$php"
        "$java"
        "$kotlin"
        "$haskell"
        "$python"
        "[](fg:color_blue bg:color_bg3)"
        "$docker_context"
        "$conda"
        "$pixi"
        "[](fg:color_bg3 bg:color_bg1)"
        "$time"
        "$cmd_duration"
        "[ ](fg:color_bg1)"
        "\${custom.git_email}"
        "$line_break"
        "$character"
      ];

      palette = "gruvbox_dark";

      palettes.gruvbox_dark = {
        color_fg0 = "#fbf1c7";
        color_bg1 = "#3c3836";
        color_bg3 = "#665c54";
        color_blue = "#458588";
        color_aqua = "#689d6a";
        color_green = "#98971a";
        color_orange = "#d65d0e";
        color_purple = "#b16286";
        color_red = "#cc241d";
        color_yellow = "#d79921";
      };

      os.disabled = true;

      username.show_always = false;

      directory = {
        style = "fg:color_fg0 bg:color_orange";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = "󰝚 ";
          "Pictures" = " ";
          "code" = "󰲋 ";
        };
      };

      git_branch = {
        symbol = "";
        style = "bg:color_aqua";
        format = "[[ $symbol $branch ](fg:color_fg0 bg:color_aqua)]($style)";
      };

      git_status = {
        style = "bg:color_aqua";
        format = "[[($all_status$ahead_behind )](fg:color_fg0 bg:color_aqua)]($style)";
      };

      # --- Languages ---

      nodejs = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      c = {
        symbol = " ";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      cpp = {
        symbol = " ";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      golang = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      php = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      java = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      kotlin = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      haskell = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      python = {
        symbol = "";
        style = "bg:color_blue";
        format = "[[ $symbol( $version) ](fg:color_fg0 bg:color_blue)]($style)";
      };

      # --- Environments ---

      docker_context = {
        symbol = "";
        style = "bg:color_bg3";
        format = "[[ $symbol( $context) ](fg:#83a598 bg:color_bg3)]($style)";
        disabled = false;
        only_with_files = true;
        detect_files = [ "docker-compose.yml" "docker-compose.yaml" "Dockerfile" "compose.yaml" ];
      };

      conda = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $environment) ](fg:#83a598 bg:color_bg3)]($style)";
      };

      pixi = {
        style = "bg:color_bg3";
        format = "[[ $symbol( $version)( $environment) ](fg:color_fg0 bg:color_bg3)]($style)";
      };

      # --- System & Time ---

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:color_bg1";
        format = "[[  $time ](fg:color_fg0 bg:color_bg1)]($style)";
      };
      
      cmd_duration = {
        min_time = 2000;
        style = "bg:color_bg1";
        format = "[[ 󰔛 $duration ](fg:color_fg0 bg:color_bg1)]($style)";
      };

      "custom.git_email" = {
        command = "git config user.email";
        when = "git rev-parse --git-dir 2> /dev/null";
        format = "as [$output]($style) ";
        style = "bright-yellow bold";
      };

      line_break.disabled = false;

      character = {
        disabled = false;
        success_symbol = "[](bold fg:color_green)";
        error_symbol = "[](bold fg:color_red)";
        vimcmd_symbol = "[](bold fg:color_green)";
        vimcmd_replace_one_symbol = "[](bold fg:color_purple)";
        vimcmd_replace_symbol = "[](bold fg:color_purple)";
        vimcmd_visual_symbol = "[](bold fg:color_yellow)";
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
