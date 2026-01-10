{ config, lib, pkgs, ... }:

{
  # Network Manager
  networking.networkmanager.enable = true;

  # Tailscale VPN
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "both";

  # Firewall configuration
  networking.firewall = {
    enable = true;
    allowedUDPPorts = [ config.services.tailscale.port ];
    trustedInterfaces = [ "tailscale0" ];
  };

  # System packages for networking
  environment.systemPackages = with pkgs; [
    tailscale
  ];
}
