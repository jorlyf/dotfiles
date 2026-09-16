{
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    pkgs.zed-editor
    pkgs.package-version-server
    pkgs.bash-language-server
  ];

  environment.sessionVariables = {
    EDITOR = "zeditor --wait";
  };

  homix = {
    ".config/zed/settings.json".source = ./config.jsonc;
    ".config/zed/themes/catppuccin-no-italics-lavender.json.json".source =
      ./catppuccin-no-italics-lavender.json;
    ".config/zed/snippets/rust.json".source = ./snippets/rust.json;
  };
}
