{
  config,
  ...
}:
{
  # Device ID: R5P52SY-S5N2VMG-FBCKIF3-JI4F7WJ-LJ3WJZ4-IVSCTW2-7ISUVYI-THB7KQV

  age.secrets = {
    "syncthing-cert" = {
      file = ./secrets/syncthing/cert.age;
      owner = "jorlyf";
      group = "syncthing";
      mode = "0600";
    };
    "syncthing-key" = {
      file = ./secrets/syncthing/key.age;
      owner = "jorlyf";
      group = "syncthing";
      mode = "0600";
    };
  };

  services.syncthing = {
    cert = config.age.secrets."syncthing-cert".path;
    key = config.age.secrets."syncthing-key".path;
    settings = {
      devices = {
        "honor" = {
          id = "RKOD3H5-E3DFIH4-WIANDRR-QIXREOK-BK7LNF5-Y5N36QS-UHQBCWO-4ZUXXQ6";
        };
        "samsung-SM9260" = {
          id = "T6OYL3Z-33HY6C7-SD64KDM-S2KJ5LT-PVA6KVT-LJC4RNS-SJ66QCM-BCM3NQA";
        };
      };
      folders = {
        "sync" = {
          path = "/home/jorlyf/persistent/sync";
          devices = [
            "honor"
            "samsung-SM9260"
          ];
        };
      };
    };
  };
}
