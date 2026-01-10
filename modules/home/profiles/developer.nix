{ config, lib, pkgs, ... }:

{
  # Developer profile - base + development tools
  imports = [
    ./base.nix
    ../development/neovim.nix
    ../development/git.nix
    ../development/languages.nix
  ];
}
