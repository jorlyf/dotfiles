{
  pkgs,
  ...
}:
{
  environment = {
    systemPackages = [
      pkgs.telegram-desktop
    ];
    etc."xdg/autostart/Telegram.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Telegram Desktop
      Comment=Official desktop version of Telegram messaging app
      Exec=Telegram -startintray
      Icon=telegram
      Terminal=false
      Categories=Network;InstantMessaging;
    '';
    persistence."/persistent" = {
      users.jorlyf = {
        directories = [
          ".local/share/TelegramDesktop"
        ];
      };
    };
  };
}
