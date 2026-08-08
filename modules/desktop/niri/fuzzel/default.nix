{
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    pkgs.fuzzel
  ];

  homix = {
    ".config/fuzzel/fuzzel.ini".source = ./fuzzel.ini;
  };
}
