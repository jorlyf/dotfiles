{
  pkgs,
  ...
}:
{
  environment = {
    systemPackages = [
      pkgs.qbittorrent
    ];
    persistence."/persistent" = {
      users.jorlyf = {
        directories = [
          ".config/qBittorrent"
        ];
      };
    };
  };
}
