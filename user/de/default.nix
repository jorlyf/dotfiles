{
  config,
  ...
}:
{
  imports = [
    ./niri
    ./waybar
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${config.programs.niri.package}/bin/niri-session";
        user = "jorlyf";
      };
    };
  };

  programs.nm-applet.enable = true;
}
