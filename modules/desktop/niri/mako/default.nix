{
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    pkgs.libnotify
    pkgs.mako
  ];

  homix = {
    ".config/mako/config".source = ./config;
  };
}
