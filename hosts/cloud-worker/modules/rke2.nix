{ config, ... }:
{
  services.rke2 = {
    enable = true;
    role = "agent";

    tokenFile = config.sops.secrets."rke2/node_token".path;
  };

  sops.secrets = {
    "rke2/node_token" = { };
  };
}
