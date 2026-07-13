# hosts/wsl-host/default.nix
{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    # Pull in the Home Manager module from your flake inputs
    inputs.home-manager.nixosModules.default
    ../../modules/system/services/docker.nix
    ../../modules/system/core/nix.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "kai";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;

  users.users.kai = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; 
    shell = pkgs.zsh;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      "kai" = import ./home.nix;
    };
  };

  time.timeZone = "Asia/Singapore";

  security.pki.certificateFiles = [
    /etc/nixos/cisco-cert.crt
  ];

  programs.nix-ld.enable = true;
  system.stateVersion = "26.05"; 
}
