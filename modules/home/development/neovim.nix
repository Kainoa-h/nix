{ pkgs, inputs, ... }:

{
  home.packages = [
    inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.nvim
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
