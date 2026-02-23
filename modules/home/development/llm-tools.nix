{ inputs, pkgs, ... }:

{
  home.packages = [
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.gemini-cli
    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode
  ];
}
