{
  ...
}:
{
  programs.fish = {
    enable = true;
  };

  environment.persistence."/persistent" = {
    users.jorlyf = {
      directories = [
        ".config/fish"
        ".local/share/fish"
      ];
    };
  };
}
