{ config, lib, pkgs, ... }:

{
  # Network Manager
  networking.wireless.enable = false;
  networking.wireless.iwd.enable = true;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  hardware.enableRedistributableFirmware = true;
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    impala
  ];
}
