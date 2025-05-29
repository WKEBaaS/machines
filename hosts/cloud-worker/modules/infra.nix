{
  lib,
  pkgs,
  config,
  ...
}:
{
  ##### Required Packages #####
  environment.systemPackages = with pkgs; [
    nfs-utils
  ];

  ##### System Required #####
  boot.supportedFilesystems = [ "nfs" ];
  boot.kernelModules = [ "rbd" ];

  services.rpcbind.enable = true;
  services.openiscsi = {
    enable = true;
    name = "iqn.2025-01.tw.edu.ncnu.csie.wke.cloud:" + config.networking.hostName;
  };

  ##### RKE2 #####
  services.rke2 = {
    enable = true;
    role = "agent";

    serverAddr = "https://10.22.23.215:9345";
    tokenFile = config.sops.secrets."rke2/node_token".path;
  };

  # Don't interfere with k8s
  networking.firewall.enable = lib.mkForce false;

  sops.secrets = {
    "rke2/node_token" = { };
  };
}
