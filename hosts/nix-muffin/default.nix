{ inputs, config, pkgs, ... }:

{
  imports = [
    # Hardware configuration
    ./hardware-configuration.nix

    # Core system modules
    ../../modules/system/core/boot.nix
    ../../modules/system/core/networking.nix
    ../../modules/system/core/locale.nix
    ../../modules/system/core/users.nix
    ../../modules/system/core/nix.nix

    # Hardware modules
    ../../modules/system/hardware/amd-gpu.nix
    ../../modules/system/hardware/audio.nix
    ../../modules/system/hardware/graphics.nix

    # Desktop environment
    ../../modules/system/desktop/hyprland.nix
    ../../modules/system/desktop/fonts.nix

    # Gaming
    ../../modules/system/gaming/steam.nix

    # Services
    ../../modules/system/services/ssh.nix
    ../../modules/system/services/virtualization.nix
    ../../modules/system/services/storage.nix
    ../../modules/system/services/secrets.nix

    # Home Manager integration
    inputs.home-manager.nixosModules.default
  ];

  # Host-specific settings
  networking.hostName = "nix-muffin";

  # System packages that haven't been modularized
  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    zoxide
    git
    lazygit
    kitty
    yazi
    zip
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    ddcui
    ddcutil
    brightnessctl
  ];

  # Home Manager configuration
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "kai" = import ./home.nix;
    };
  };

  users.users.kai.extraGroups = [ "i2c" ];

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

  systemd.services.ddcci-setup = {
    description = "Create ddcci device for external monitor";
    after = [ "display-manager.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'sleep 3 && echo ddcci 0x37 > /sys/bus/i2c/devices/i2c-6/new_device'";
    };
  };

  virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
  };

  # some stuff so Mason can download stuff
  programs.nix-ld.enable = true;

  # NixOS state version
  system.stateVersion = "25.11";
}
