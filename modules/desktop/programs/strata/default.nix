{
  inputs,
  pkgs,
  ...
}:
let
  strata = inputs.strata.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  environment.systemPackages = [ strata ];

  xdg = {
    portal = {
      extraPortals = [ strata.fileChooserPortal ];
      config.common."org.freedesktop.impl.portal.FileChooser" = [
        "strata"
        "gtk"
      ];
    };
  };

  services.dbus.packages = [ strata.fileManagerService ];

  homix = {
    ".config/strata/settings.toml".source = ./settings.toml;
  };
}
