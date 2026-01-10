{ config, lib, pkgs, ... }:

{
  # OpenSSH daemon
  services.openssh.enable = true;
}
