{ config, lib, pkgs, ... }:

{
  # Programming language runtimes and tools
  home.packages = with pkgs; [
    claude-code
  ];
}
