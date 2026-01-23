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
    withNodeJs = true;
  };

  # Symlink to external nvim configuration
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/nvim";

  # Session variable
  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
