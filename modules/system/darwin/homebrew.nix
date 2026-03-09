{ config, lib, pkgs, ... }:

{
  # Enable Homebrew integration
  homebrew = {
    enable = true;

    # Automatically run cleanup
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";  # Uninstall unlisted packages
      upgrade = true;
    };

    # Homebrew taps
    taps = [
    ];

    casks = [
      "ghostty"
      "nikitabobko/tap/aerospace"
      "raycast"
      "font-sf-pro"
      "font-hack-nerd-font"
      "sf-symbols"
      "font-caskaydia-cove-nerd-font"
      "chromium"
      "pearcleaner"
      "betterdisplay"
      "unnaturalscrollwheels"
      "karabiner-elements"
      "tailscale-app"
    ];

    # CLI tools not in nixpkgs or better via brew
    brews = [
      # Add specific brews if needed
      "kanata"
      "kainoa-h/homebrew-tap/ncspot-controller"
      "kainoa-h/homebrew-tap/kanata-layer-observer"
    ];

    # Mac App Store apps (requires mas-cli)
    masApps = {
      # "App Name" = app_id;
      # Example: "Xcode" = 497799835;
    };
  };
}
