{
  inputs,
  lib,
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
      enable = true;
      extraPortals = [ strata.fileChooserPortal ];
      config = {
        common."org.freedesktop.impl.portal.FileChooser" = lib.mkForce [
          "strata"
          "gtk"
        ];
        niri."org.freedesktop.impl.portal.FileChooser" = lib.mkForce [
          "strata"
          "gnome"
          "gtk"
        ];
      };
    };
  };

  services.dbus.packages = [ strata.fileManagerService ];

  homix = {
    ".config/strata/settings.toml".source = ./settings.toml;
    ".config/gtk-3.0/bookmarks".source = ./bookmarks;
  };
}
