{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    ghostty
  ];

  homix = {
    ".config/ghostty/themes".source = ./themes;
    ".config/ghostty/config.ghostty".source = ./config.ghostty;
  };
}
