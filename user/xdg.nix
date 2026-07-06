{
  pkgs,
  ...
}:
{
  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };
    mime = {
      enable = true;
      defaultApplications = {
        "inode/directory" = "yazi.desktop";
      };
    };
  };
}
