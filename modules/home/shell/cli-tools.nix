{ config, lib, pkgs, ... }:

{
  # CLI utility packages
  home.packages = with pkgs; [
    bat
    fzf
    trash-cli
    gitleaks
    file
    ripgrep
    unzip
    gzip
    curl
    jq
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    # linux/wayland-specific tools
    wl-clipboard
    grim
    slurp
    btop-rocm
  ] ++ lib.optionals pkgs.stdenv.isDarwin [
    # macos stuff
    btop
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
