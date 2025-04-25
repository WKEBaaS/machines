{ self }:
let
  inherit (self) inputs outputs;
  inherit (inputs)
    nixpkgs
    home-manager
    ;

  username = "baas";

  homeDir = self + /homes;
  hm-nixos = home-manager.nixosModules.home-manager;
in
{

  nixosConfigurations =
    let
      hosts = [
        {
          name = "nixos-server";
          config = ./nixos-server/configuration.nix;
        }
      ];
    in
    builtins.listToAttrs (
      map (host: {
        name = host.name;
        value = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit outputs inputs username;
            isDarwin = false;
          };
          system = "x86_64-linux";
          modules = [
            host.config
            homeDir
            hm-nixos
            {
              # Impurity
              imports = [ inputs.impurity.nixosModules.impurity ];
              impurity.configRoot = self;
              impurity.enable = true;
            }
          ];
          # ========== Extend lib with lib.custom ==========
          # NOTE: This approach allows lib.custom to propagate into hm
          # see: https://github.com/nix-community/home-manager/pull/3454
          lib = nixpkgs.lib.extend (self: super: { custom = import ../lib { inherit (nixpkgs) lib; }; });
        };
      }) hosts
    );
}
