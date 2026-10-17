{
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    pkgs.libnotify
    pkgs.mako
  ];

  # // Черное окно уведомлений mako при записи экрана.
  # layer-rule {
  #   match namespace="^notifications$"
  #   block-out-from "screencast"
  # }

  homix = {
    ".config/mako/config".source = ./config;
  };
}
