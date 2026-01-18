{ inputs, config, pkgs, ... }:

{
  imports = [
    # Darwin system modules
    ../../modules/system/darwin/nix.nix
    ../../modules/system/darwin/users.nix
    ../../modules/system/darwin/system.nix
    ../../modules/system/darwin/homebrew.nix
  ];

  # Hostname
  networking.hostName = "muffin-oven";
  networking.computerName = "muffin-oven";

  # Minimal system packages
  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  # Home Manager configuration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users = {
      "kai" = import ./home.nix;
    };
  };

  # nix-darwin state version
  system.stateVersion = 5;
}
