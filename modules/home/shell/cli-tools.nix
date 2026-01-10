{ config, lib, pkgs, ... }:

{
  # CLI utility packages
  home.packages = with pkgs; [
    bat
    fzf
    trash-cli
    btop
    wl-clipboard
    grim
    slurp
    gitleaks
  ];

  # Eza (modern ls replacement)
  programs.eza = {
    enable = true;
    icons = "auto";
  };

  # Zoxide (directory jumper)
  programs.zoxide.enable = true;

  # Pay-respects (f command)
  programs.pay-respects = {
    enable = true;
    enableZshIntegration = true;
  };

  # FZF fuzzy finder
  programs.fzf.enable = true;
}
