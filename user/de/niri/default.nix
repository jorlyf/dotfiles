{
  ...
}:
{
  programs.niri = {
    enable = true;
    useNautilus = false;
  };

  environment.etc."niri/config.kdl".source = ./config.kdl;
  environment.sessionVariables.NIRI_CONFIG = "/etc/niri/config.kdl";
}
