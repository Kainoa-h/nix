{ config, lib, pkgs, ... }:

{
  # Default shell for all users
  users.defaultUserShell = pkgs.zsh;

  # Shell configuration
  environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;

  # User account
  users.users.kai = {
    isNormalUser = true;
    description = "kai";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };
}
