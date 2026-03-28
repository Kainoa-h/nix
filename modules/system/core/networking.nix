{ config, lib, pkgs, ... }:

{
  # Network Manager
  networking.networkmanager.enable = true;
  networking.nameservers = ["1.1.1.1" "8.8.8.8"];
  networking.enableIPv6 = false;

  networking.hosts = {
      "127.0.0.1" = [ "localhost" "site.local"];
  };

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
    lsof
  ];
}
