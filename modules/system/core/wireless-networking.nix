{ config, lib, pkgs, ... }:

{
  # Network Manager
  networking.networkmanager.enable = true;
  networking.wireless.enable = true;
  hardware.enableRedistributableFirmware = true;
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    wifitui
  ];
}
