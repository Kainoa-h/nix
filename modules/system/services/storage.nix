{ config, lib, pkgs, ... }:

{
  # Storage and file system services
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
