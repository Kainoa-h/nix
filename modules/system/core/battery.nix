{ config, lib, pkgs, ... }:

{
  powerManagement.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq.enable = false;

  services.tlp = {
    enable = true;

    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";

      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandleLidSwitchDocked = "ignore";
  };
}
