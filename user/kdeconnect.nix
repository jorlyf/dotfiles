{
  config,
  ...
}:
{
  programs.kdeconnect = {
    enable = true;
  };

  systemd.user.services.kdeconnectd = {
    description = "KDE Connect service";
    requires = [ "dbus.socket" ];
    after = [ "dbus.socket" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${config.programs.kdeconnect.package}/libexec/kdeconnectd";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
}
