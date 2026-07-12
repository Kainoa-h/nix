{ config, lib, pkgs, ... }:

{
  # Developer profile - base + development tools
  imports = [
    ./base.nix
    ../development/neovim.nix
    ../development/git.nix
    ../development/zed.nix
    ../development/llm-tools.nix
    ../development/notes.nix
  ];
}
