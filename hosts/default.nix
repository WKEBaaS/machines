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

  mkHost =
    { name, config }:
    nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit outputs inputs username;
        isDarwin = false;
      };
      system = "x86_64-linux";
      modules = [
        {
          # Hostname
          networking.hostName = name;

          # Impurity
          imports = [ inputs.impurity.nixosModules.impurity ];
          impurity.configRoot = self;
          impurity.enable = true;
        }
        config
        homeDir
        hm-nixos
      ];
    };
in
{

  nixosConfigurations =
    let
      hosts = [
        {
          name = "cloud-server";
          config = ./nixos-server/configuration.nix;
        }
        {
          name = "cloud-worker-01";
          config = ./nixos-worker/configuration.nix;
        }
      ];
    in
    builtins.listToAttrs (
      map (host: {
        name = host.name;
        value = mkHost host.name host.config;
      }) hosts
    );
}
