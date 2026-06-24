{
  ...
}:
{
  programs.waybar.enable = true;

  environment.etc."xdg/waybar/config.jsonc".source = ./config.jsonc;
  environment.etc."xdg/waybar/style.css".source = ./style.css;
}
