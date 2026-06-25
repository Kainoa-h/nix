{ config, lib, pkgs, ... }:

{
  # Steam gaming platform
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Opens ports for Remote Play
    dedicatedServer.openFirewall = true; # Opens ports for dedicated servers
    extest.enable = true;
  };

  programs.gamescope.enable = true;
}
