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
    description = "Auto-detect and register ddcci devices for external monitors";
    after = [ "display-manager.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "ddcci-auto-detect" ''
        sleep 3

        ${pkgs.ddcutil}/bin/ddcutil detect 2>/dev/null | \
        ${pkgs.gnused}/bin/sed -n 's/I2C bus:\s*\/dev\/\(i2c-[0-9]*\)/\1/p' | \
        while read -r i2c_dev; do
          i2c_num=''${i2c_dev#i2c-}
          
          if [ -d "/sys/bus/i2c/devices/$i2c_dev/$i2c_dev-0037" ]; then
            echo "ddcci already registered on /dev/$i2c_dev"
            continue
          fi
          
          echo "Registering ddcci on /dev/$i2c_dev"
          echo "ddcci 0x37" > "/sys/bus/i2c/devices/$i2c_dev/new_device" 2>/dev/null || true
          sleep 1
        done
      ''}";
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
  system.stateVersion = "26.05";
}
