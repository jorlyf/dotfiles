{
  ...
}:
{
  programs.niri = {
    enable = true;
    # Сделать, когда настрою yazi полностью
    # useNautilus = false;
  };

  environment.etc."niri/config.kdl".source = ./config.kdl;
  environment.sessionVariables.NIRI_CONFIG = "/etc/niri/config.kdl";
}
