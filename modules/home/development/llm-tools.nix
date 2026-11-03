{ inputs, lib, pkgs, ... }:

{

  home.packages = lib.optionals pkgs.stdenv.hostPlatform.isLinux [
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode2
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.codex
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.codex-acp
  ];
}
