{ config, lib, pkgs, inputs, ... }:

{
  # Walker app launcher
  programs.walker = {
    enable = true;
    runAsService = true;

    config = {
      providers = {
        default = [
          "desktopapplications"
          "runner"
          "calc"
        ];

        empty = [
          "desktopapplications"
        ];
      };
    };
  };

  # Elephant launcher package
  home.packages = [
    inputs.elephant.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
