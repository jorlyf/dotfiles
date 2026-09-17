{
  inputs,
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

  age.identityPaths = [
    "/persistent/etc/ssh/ssh_host_ed25519_key"
  ];

  environment.systemPackages = [
    inputs.agenix.packages.${pkgs.system}.default
  ];
}
