{ config, lib, pkgs, ... }:

{
  # Neovim editor configuration
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

  # Symlink to external nvim configuration
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/kai/nixos-config/nvim";

  # Session variable
  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
