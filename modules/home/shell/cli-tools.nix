{ config, lib, pkgs, ... }:

{
  # CLI utility packages
  home.packages = with pkgs; [
    bat
    fzf
    trash-cli
    btop-rocm
    gitleaks
    file
    ripgrep
    unzip
    gzip
    curl
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    # Linux/Wayland-specific tools
    wl-clipboard
    grim
    slurp
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
