{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    niri-config-append-lines = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Строки, которые будут добавлены в начало config.kdl";
    };
  };

  config = {
    programs.niri = {
      enable = true;
      useNautilus = false;
    };

    environment.sessionVariables.NIRI_CONFIG = "/etc/niri/config.kdl";
    environment.etc."niri/config.kdl".text = ''
      ${config.niri-config-append-lines}

      ${builtins.readFile ./config.kdl}
    '';

    environment.systemPackages = with pkgs; [
      catppuccin-cursors.frappeLavender
      playerctl
    ];
    services.playerctld.enable = true;
  };
}
