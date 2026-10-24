{
  pkgs,
  ...
}:
{
  fonts = {
    enableDefaultPackages = true;

    packages = [
      pkgs.corefonts
      pkgs.fira-code
      pkgs.fira-code-symbols
      pkgs.font-awesome
      pkgs.liberation_ttf
      pkgs.nerd-fonts.fira-code
      pkgs.nerd-fonts.iosevka
      pkgs.nerd-fonts.symbols-only
      pkgs.noto-fonts
      pkgs.noto-fonts-cjk-sans
      pkgs.noto-fonts-color-emoji
      pkgs.vista-fonts
    ];
  };
}
