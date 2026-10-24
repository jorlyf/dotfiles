{
  ...
}:
{
  programs.obs-studio = {
    enable = true;
  };

  environment.persistence."/persistent" = {
    users.jorlyf = {
      directories = [
        ".config/obs-studio"
      ];
    };
  };
}
