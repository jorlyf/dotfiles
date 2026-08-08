{
  config,
  ...
}:
{
  programs.kdeconnect = {
    enable = true;
  };

  systemd.user.services.kdeconnect-indicator = {
    description = "KDE Connect indicator service";
    requires = [ "dbus.socket" ];
    after = [
      "dbus.socket"
      "graphical-session.target"
    ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${config.programs.kdeconnect.package}/bin/kdeconnect-indicator";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
}
