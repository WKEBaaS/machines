{
  lib,
  pkgs,
  ...
}:
{
  ##### Required Packages #####
  environment.systemPackages = with pkgs; [
    nfs-utils
    cryptsetup
    openiscsi
  ];

  ##### Required Services #####
  # used for longhorn
  services.openiscsi = {
    enable = true;
    name = "iqn.2025-01.tw.edu.ncnu.csie.wke.cloud:cloud-server";
  };

  ##### RKE2 #####
  services.rke2 = {
    enable = true;
    role = "server";

    extraFlags = [
      "--cluster-cidr=172.19.0.0/16"
      "--service-cidr=172.20.0.0/16"
    ];

    disable = [
      "rke2-ingress-nginx"
    ];
  };

  # Don't interfere with k8s
  networking.firewall.enable = lib.mkForce false;
}
