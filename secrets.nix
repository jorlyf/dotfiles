let
  jorlyf-rsa = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/yHjLgWq1zka2rtpkHos/I4Yv19USnkh512PniZM6upW3BMNyrQuTiK8YUQWcBXKjBjlZfGdp64gJnv9MTFiBMp+cHGLVZktr5kl94GqCwkPlckvrhSlcFsgk8SMyHA9dyNki7uU0v5HrD9T4FQJTSXkwPSBQrczQdzUAnOEP/Q73KEzwUinKVXgH62GRd0o5mdRdXOXnxpErPbGTAy2zNP6zl0mb+FliSNy9lFtR5mxE9i5x8ro7DVl+l+5ylX9CyA3M/gQYJh/sT/7Umw65j3dWzwyapMHWV5ALO+o5cgzgwR9nJ/Pf+uhhvUcUSE2DAgYGq2xNb6o4epekQhmupcJPoygz8PY7gzOGf/RHlRx9Ha8hsGy+3cBzk34K5FsnIzLu+Z7v2YgZNj3u0m+L706k1vdUV2ToCJ5zKlZSGrDUg8SfS0td9WH/9M+plsJthirehDgs6FUWeVOUq//d7N+WHdAqnArGzn3ZifOSsb6j89SK3LxWV1I/s/3y7Ac= jorlyf@jorlyf";

  honor-system-ed25519 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFFPjd8t9p7bolf0onb7BeFkOQRJSmRPz97qaawWtPNA root@honor";
  pc-system-ed25519 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMzaUzfy5FEdXGhM8eOXDtozZ+ptyi7l5869vW8OyVkJ root@pc";
in
{
  "secrets/user-password.age".publicKeys = [
    jorlyf-rsa
    honor-system-ed25519
    pc-system-ed25519
  ];

  "hosts/honor/secrets/syncthing/cert.age".publicKeys = [
    jorlyf-rsa
    honor-system-ed25519
  ];
  "hosts/honor/secrets/syncthing/key.age".publicKeys = [
    jorlyf-rsa
    honor-system-ed25519
  ];

  "hosts/pc/secrets/syncthing/cert.age".publicKeys = [
    jorlyf-rsa
    pc-system-ed25519
  ];
  "hosts/pc/secrets/syncthing/key.age".publicKeys = [
    jorlyf-rsa
    pc-system-ed25519
  ];
}
