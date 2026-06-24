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
          ./${name}
        ];
        # ++ builtins.attrValues self.nixosModules;

      specialArgs = {
        inherit inputs;
        flake = self;
      };
    };
in {
  honor = mkHost "honor" "x86_64-linux";
}
