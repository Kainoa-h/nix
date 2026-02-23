{ config, lib, pkgs, ... }:

{
  # Podman containerization
  virtualisation.podman = {
    enable = true;
    # Create a 'docker' alias for podman
    dockerCompat = true;
    # Enable podman socket (for docker-compose compatibility)
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  #  Tell nixos to pass down delegates to users so k3d can use them
  systemd.services."user@".serviceConfig.Delegate = "memory pids cpu cpuset io";

  # Install podman-compose
  environment.systemPackages = with pkgs; [
    podman-compose
    k3d
    kubectl
    k9s
  ];

  users.users.kai.extraGroups = [ "podman" ];
}
