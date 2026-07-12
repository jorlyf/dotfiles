{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    ashell
  ];

  systemd.user.services.ashell = {
    enable = true;
    description = "Ashell";

    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.ashell}/bin/ashell";
      Restart = "on-failure";
      RestartSec = 3;
    };
  };

  homix = {
    ".config/ashell/config.toml".source = ./config.toml;
  };
}
