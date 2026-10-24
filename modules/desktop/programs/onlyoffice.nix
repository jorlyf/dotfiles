{
  pkgs,
  ...
}:
{
  environment = {
    systemPackages = [
      pkgs.onlyoffice-desktopeditors
    ];
    persistence."/persistent" = {
      users.jorlyf = {
        directories = [
          ".config/onlyoffice"
          ".local/share/onlyoffice"
        ];
      };
    };
  };

  # Для OnlyOffice (не отображаются установленные в системе шрифты)
  systemd.user.services.corefonts-to-home = {
    description = "Link fonts to user directory on login";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.coreutils}/bin/mkdir -p %h/.local/share/fonts && ${pkgs.coreutils}/bin/cp -r ${pkgs.corefonts}/share/fonts/truetype %h/.local/share/fonts/corefonts'";
    };
  };
}
