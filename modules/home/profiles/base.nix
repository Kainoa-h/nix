{ config, lib, pkgs, ... }:

{
  # Minimal base profile - shell and core CLI tools
  imports = [
    ../shell/zsh.nix
    ../shell/starship.nix
    ../shell/tmux.nix
    ../shell/cli-tools.nix
    ../shell/direnv.nix
    ../shell/sesh.nix
  ];
}
