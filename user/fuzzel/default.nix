{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    fuzzel
  ];

  homix = {
    ".config/fuzzel/fuzzel.ini".source = ./fuzzel.ini;
  };
}
