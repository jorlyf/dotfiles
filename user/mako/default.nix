{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    libnotify
    mako
  ];

  homix = {
    ".config/mako/config".source = ./config;
  };
}
