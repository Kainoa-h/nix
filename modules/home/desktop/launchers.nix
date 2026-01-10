{ config, lib, pkgs, inputs, ... }:

{
  # Walker app launcher
  programs.walker = {
    enable = true;
    runAsService = false;
  };

  # Elephant launcher package
  home.packages = [
    inputs.elephant.packages.${pkgs.system}.default
  ];
}
