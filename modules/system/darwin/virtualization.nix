{ config, lib, pkgs, ... }:

{
  # Install virtualization tools for Darwin
  # Note: On Darwin, podman requires a virtual machine to run containers.
  # You will need to initialize and start it manually after installation:
  # $ podman machine init
  # $ podman machine start
  environment.systemPackages = with pkgs; [
    podman
    podman-compose
    k3d
    kubectl
    k9s
    # qemu is required for podman machine on macOS
    qemu
  ];
}
