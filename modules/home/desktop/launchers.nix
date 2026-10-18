{ pkgs, ... }:

{
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };

  # Walker app launcher
  programs.walker = {
    enable = true;
    runAsService = true;

    config = {
      providers = {
        default = [
          "desktopapplications"
          "runner"
          "calc"
        ];

        empty = [
          "desktopapplications"
        ];
      };
    };
  };

  # Walker enables Elephant; its module owns the package and backend service.
  programs.elephant.installService = true;
}
