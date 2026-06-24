{
  pkgs,
  ...
}:
{
  users = {
    mutableUsers = false;

    users = {
      root = {
        initialPassword = "admin";
      };

      jorlyf = {
        isNormalUser = true;
        uid = 1000;
        initialPassword = "admin";

        shell = pkgs.fish;

        extraGroups = [
          "networkmanager"
          "podman"
          "systemd-journal"
          "wheel"
        ];

        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/yHjLgWq1zka2rtpkHos/I4Yv19USnkh512PniZM6upW3BMNyrQuTiK8YUQWcBXKjBjlZfGdp64gJnv9MTFiBMp+cHGLVZktr5kl94GqCwkPlckvrhSlcFsgk8SMyHA9dyNki7uU0v5HrD9T4FQJTSXkwPSBQrczQdzUAnOEP/Q73KEzwUinKVXgH62GRd0o5mdRdXOXnxpErPbGTAy2zNP6zl0mb+FliSNy9lFtR5mxE9i5x8ro7DVl+l+5ylX9CyA3M/gQYJh/sT/7Umw65j3dWzwyapMHWV5ALO+o5cgzgwR9nJ/Pf+uhhvUcUSE2DAgYGq2xNb6o4epekQhmupcJPoygz8PY7gzOGf/RHlRx9Ha8hsGy+3cBzk34K5FsnIzLu+Z7v2YgZNj3u0m+L706k1vdUV2ToCJ5zKlZSGrDUg8SfS0td9WH/9M+plsJthirehDgs6FUWeVOUq//d7N+WHdAqnArGzn3ZifOSsb6j89SK3LxWV1I/s/3y7Ac= jorlyf@jorlyf"
        ];
      };
    };
  };
}
