{ config, lib, pkgs, ... }:

{
  # AMD GPU configuration
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  environment.systemPackages = [
    pkgs.rocmPackages.rocm-smi
  ];
}
