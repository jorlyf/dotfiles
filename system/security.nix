{
  lib,
  pkgs,
  ...
}:
{
  services.gnome.gnome-keyring.enable = lib.mkForce false;

  security = {
    pam = {
      services = {
        login.enableGnomeKeyring = lib.mkForce false;
      };
    };
  };

  environment.etc."xdg/autostart/org.keepassxc.KeePassXC.desktop".source =
    "${pkgs.keepassxc}/share/applications/org.keepassxc.KeePassXC.desktop";
}
