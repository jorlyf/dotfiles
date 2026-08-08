{
  ...
}:
{
  services.syncthing = {
    enable = true;
    user = "jorlyf";
    dataDir = "/home/jorlyf/.config/syncthing";
    configDir = "/home/jorlyf/.config/syncthing";
    guiAddress = "127.0.0.1:8384";
    openDefaultPorts = true;
  };
}
