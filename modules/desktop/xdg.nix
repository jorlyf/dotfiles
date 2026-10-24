{
  pkgs,
  ...
}:
{
  environment = {
    sessionVariables = {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";
    };

    systemPackages = [ pkgs.xdg-user-dirs ];

    etc."xdg/user-dirs.defaults".text = ''
      DOCUMENTS=documents
      DOWNLOAD=downloads
      PICTURES=pictures
      VIDEOS=
      MUSIC=
      DESKTOP=
      TEMPLATES=
      PUBLICSHARE=
    '';

    persistence."/persistent" = {
      users.jorlyf = {
        directories = [
          ".local/share/Trash"
          "documents"
          "downloads"
          "pictures"
        ];
      };
    };
  };

  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };
    mime = {
      enable = true;
    };
  };
}
