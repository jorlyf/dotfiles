{
  pkgs,
  ...
}:
{
  environment = {
    systemPackages = [
      pkgs.zed-editor
      pkgs.package-version-server
      pkgs.bash-language-server
    ];
    sessionVariables = {
      EDITOR = "zeditor --wait";
    };
    persistence."/persistent" = {
      users.jorlyf = {
        directories = [
          ".local/share/zed"
        ];
      };
    };
  };

  homix = {
    ".config/zed/settings.json".source = ./config.jsonc;
    ".config/zed/themes/catppuccin-no-italics-lavender.json.json".source =
      ./catppuccin-no-italics-lavender.json;
    ".config/zed/snippets/rust.json".source = ./snippets/rust.json;
  };
}
