{ config, lib, pkgs, ... }:

{
  # System-wide settings for macOS
  system.primaryUser = "kai";

  system.defaults = {
    # Dock settings
    dock = {
      autohide = true;
      mru-spaces = false;  # Don't rearrange spaces
      show-recents = false;
    };

    # Finder settings
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = false;
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
    };

    # NSGlobalDomain (general UI settings)
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";  # Dark mode
      AppleShowAllExtensions = true;
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      "com.apple.mouse.tapBehavior" = 1;  # Tap to click
      _HIHideMenuBar = true;
    };
  };

  # Keyboard settings
  system.keyboard = {
    enableKeyMapping = true;
    # remapCapsLockToEscape = true;
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  launchd.user.envVariables = {
      LUA_CPATH = "${pkgs.sbarlua}/lib/lua/5.5/?.so;;";
      LUA_PATH = "${pkgs.sbarlua}/share/lua/5.5/?.lua;;";
  };
}
