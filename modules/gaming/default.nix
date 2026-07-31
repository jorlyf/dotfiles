{
  pkgs,
  ...
}:
{
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraArgs = "-system-composer";
    };
  };

  environment.systemPackages = with pkgs; [
    discord
    gamemode
    mangohud
  ];
}
