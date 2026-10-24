{
  pkgs,
  ...
}:
{
  imports = [
    ./games
  ];

  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraArgs = "-system-composer";
    };
  };

  environment = {
    systemPackages = [
      pkgs.discord
      pkgs.gamemode
      pkgs.mangohud
    ];
    persistence."/persistent" = {
      users.jorlyf = {
        directories = [
          ".config/discord"
          ".local/share/Steam"
        ];
      };
    };
  };
}
