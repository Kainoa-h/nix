{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kanata
  ];

  programs.zsh.shellAliases = {
    kan = "sudo kanata --port 1012 --cfg ~/nixos-config/kanata/$(hostname).kbd > /dev/null";
  };
}
