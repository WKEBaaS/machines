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
    {
      name,
      config,
      hardwareConfig,
    }:
    nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit outputs inputs username;
        isDarwin = false;
      };
      system = "x86_64-linux";
      modules = [
        {
          imports = [
            hardwareConfig
            inputs.impurity.nixosModules.impurity
          ];
          # Hostname
          networking.hostName = name;

          # Impurity
          impurity.configRoot = self;
          impurity.enable = true;
        }
        config
        homeDir
        hm-nixos
      ];
      lib = nixpkgs.lib.extend (self: super: { custom = import ../lib { inherit (nixpkgs) lib; }; });
    };
in
{

  nixosConfigurations =
    let
      hosts = [
        {
          name = "cloud-server";
          config = ./cloud-server/configuration.nix;
          hardwareConfig = ./hardwares/cloud-server.nix;
        }
        {
          name = "cloud-worker-01";
          config = ./cloud-worker/configuration.nix;
          hardwareConfig = ./hardwares/cloud-worker-01.nix;
        }
        {
          name = "cloud-worker-02";
          config = ./cloud-worker/configuration.nix;
          hardwareConfig = ./hardwares/cloud-worker-02.nix;
        }
        {
          name = "cloud-worker-03";
          config = ./cloud-worker/configuration.nix;
          hardwareConfig = ./hardwares/cloud-worker-03.nix;
        }
        {
          name = "cloud-lb";
          config = ./cloud-lb/configuration.nix;
          hardwareConfig = ./hardwares/cloud-lb.nix;
        }
      ];
    in
    builtins.listToAttrs (
      map (host: {
        name = host.name;
        value = mkHost host;
      }) hosts
    );
}
