{ inputs, config, pkgs, ... }:

{
  imports = [
    # Hardware configuration
    ./hardware-configuration.nix

    # Core system modules
    ../../modules/system/core/boot.nix
    ../../modules/system/core/networking.nix
    ../../modules/system/core/wireless-networking.nix
    ../../modules/system/core/locale.nix
    ../../modules/system/core/users.nix
    ../../modules/system/core/battery.nix
    ../../modules/system/core/nix.nix

    # Hardware modules
    ../../modules/system/hardware/audio.nix
    ../../modules/system/hardware/graphics.nix

    # Desktop environment
    ../../modules/system/desktop/hyprland.nix
    ../../modules/system/desktop/fonts.nix

    # Services
    ../../modules/system/services/storage.nix
    ../../modules/system/services/secrets.nix

    # Home Manager integration
    inputs.home-manager.nixosModules.default
  ];

  # Host-specific settings
  networking.hostName = "muffin-lite";

  # System packages that haven't been modularized
  environment.systemPackages = with pkgs; [
    vim
    wget
    zoxide
    git
    lazygit
    kitty
    yazi
    zip
  ];

  # Home Manager configuration
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "kai" = import ./home.nix;
    };
  };

  users.users.kai.extraGroups = [ "i2c" ];

  security.pam.services.hyprlock = {
    unixAuth = true;
    fprintAuth = false;
    u2fAuth = false;
  };

  security.sudo.extraRules = [
    {
      users = [ "kai" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/systemctl suspend";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/systemctl hibernate";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    priority = 100;
  };

  virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
  };

  # some stuff so Mason can download stuff
  programs.nix-ld.enable = true;

  # NixOS state version
  system.stateVersion = "26.05";
}
