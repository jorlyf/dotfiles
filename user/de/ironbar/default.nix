{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    ironbar
    upower
  ];

  environment.sessionVariables.IRONBAR_CONFIG = "/etc/xdg/ironbar/config.toml";
  environment.etc."xdg/ironbar/config.toml".source = ./config.toml;
  # environment.etc."xdg/ironbar/style.css".source = ./style.css;

  systemd.user.services.ironbar = {
    description = "Ironbar";

    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.ironbar}/bin/ironbar";
      Restart = "on-failure";
      RestartSec = 3;
    };
  };
}
