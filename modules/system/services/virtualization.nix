{ config, lib, pkgs, ... }:

{
  # Podman containerization
  virtualisation.podman = {
    enable = true;
    # Create a 'docker' alias for podman
    dockerCompat = true;
    # Enable podman socket (for docker-compose compatibility)
    dockerSocket.enable = true;
  };

  # Install podman-compose
  environment.systemPackages = with pkgs; [
    podman-compose
  ];
}
