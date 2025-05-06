{ config, ... }:
{
  services.rke2 = {
    enable = true;
    role = "agent";

    serverAddr = "https://10.22.23.215:9345";
    tokenFile = config.sops.secrets."rke2/node_token".path;
  };

  sops.secrets = {
    "rke2/node_token" = { };
  };

  networking.firewall.allowedTCPPorts = [
    10250
    # Cilium ports
    4240
    8472
  ];
}
