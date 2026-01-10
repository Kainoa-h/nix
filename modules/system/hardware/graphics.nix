{ config, lib, pkgs, ... }:

{
  # Base graphics configuration
  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
  };
}
