{ config, ... }:
{
  services.rke2 = {
    enable = true;
    role = "agent";

    serverAddr = "10.22.23.215";
    tokenFile = config.sops.secrets."rke2/node_token".path;
  };

  sops.secrets = {
    "rke2/node_token" = { };
  };
}
