{ config, lib, pkgs, ... }:

{
  programs.sesh = {
    enable = true;
    enableTmuxIntegration = false;
    enableAlias = false;
  };
}
