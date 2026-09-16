{
  ...
}:
{
  services.syncthing = {
    enable = true;
    # Пользователь, от которого запустится syncthing. Папки находятся в /home/jorlyf, поэтому так.
    user = "jorlyf";
    configDir = "/home/jorlyf/.config/syncthing";
    dataDir = "/home/jorlyf";
    guiAddress = "127.0.0.1:8384";
    openDefaultPorts = true;
    settings = {
      gui = {
        user = "jorlyf";
        startBrowser = false;
      };
    };
  };

  environment.persistence."/persistent" = {
    users.jorlyf = {
      directories = [
        ".config/syncthing"
      ];
    };
  };
}
