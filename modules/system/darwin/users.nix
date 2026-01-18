{ config, lib, pkgs, ... }:

{
  # Define user account
  users.users.kai = {
    name = "kai";
    home = "/Users/kai";
    shell = pkgs.zsh;
  };

  # Enable zsh system-wide
  programs.zsh.enable = true;
}
