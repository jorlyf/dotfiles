{
  pkgs,
  ...
}:
{
  environment = {
    systemPackages = [
      pkgs.keepassxc
    ];
    persistence."/persistent" = {
      users.jorlyf = {
        directories = [
          ".config/keepassxc"
        ];
      };
    };
  };
}
