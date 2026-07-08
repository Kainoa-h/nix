{ config, lib, pkgs, ... }:

{
  virtualisation.docker.enable = true;
  users.users.kai.extraGroups = [ "docker" ];
}
