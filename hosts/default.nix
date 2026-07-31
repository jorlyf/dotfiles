{
  self,
  nixpkgs,

  ...
}: let
  inherit (self) inputs;
  mkHost = name: system:
    nixpkgs.lib.nixosSystem {
      modules =
        [
          {
            networking.hostName = name;
            nixpkgs.hostPlatform = system;
          }
          inputs.zapret-discord-youtube.nixosModules.withTestTools
          ./${name}
        ];

      specialArgs = {
        inherit inputs;
        flake = self;
      };
    };
in {
  honor = mkHost "honor" "x86_64-linux";
  pc = mkHost "pc" "x86_64-linux";
}
