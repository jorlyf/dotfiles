{
  config,
  lib,
  pkgs,
  ...
}:
{
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-termfilechooser
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      };
      niri = {
        "org.freedesktop.impl.portal.FileChooser" = lib.mkForce [ "termfilechooser" ];
      };
    };
  };

  system.activationScripts.createTermfilechooserConfigsDirect = {
    text = ''
      mkdir -p ${config.users.users.jorlyf.home}/.config/xdg-desktop-portal-termfilechooser

      cat > ${config.users.users.jorlyf.home}/.config/xdg-desktop-portal-termfilechooser/config << 'EOF'
      [filechooser]
      cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
      env=TERMCMD='ghostty --title="filechooser" -e'
      env=PATH="$PATH:/run/current-system/sw/bin"
      default_dir=$HOME
      open_mode = suggested
      save_mode = last
      EOF

      chown -R ${config.users.users.jorlyf.name}:${config.users.users.jorlyf.group} ${config.users.users.jorlyf.home}/.config/xdg-desktop-portal-termfilechooser
      chmod 644 ${config.users.users.jorlyf.home}/.config/xdg-desktop-portal-termfilechooser/config
    '';
  };

  systemd.user.services."xdg-desktop-portal-termfilechooser" = {
    enable = true;
  };
}
