{ ... }:

{
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
