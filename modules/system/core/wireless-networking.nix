{ config, lib, pkgs, ... }:

{
  # Network Manager
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  hardware.enableRedistributableFirmware = true;
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    impala
  ];
}
