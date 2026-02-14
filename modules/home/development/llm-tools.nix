{ inputs, pkgs, ... }:

{
  home.packages = [
    inputs.llm-agents.packages.${pkgs.system}.gemini-cli
    inputs.llm-agents.packages.${pkgs.system}.opencode
  ];
}
