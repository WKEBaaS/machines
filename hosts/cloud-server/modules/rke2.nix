{ lib, pkgs, ... }:
{
  ##### Required Packages #####
  environment.systemPackages = with pkgs; [
    nfs-utils
  ];

  ##### Required Services #####
  virtualisation.cri-o.enable = true;
  # virtualisation.containerd.enable = true;

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
      "--disable-kube-proxy"
      "--cluster-cidr=172.19.0.0/16"
      "--service-cidr=172.20.0.0/16"
    ];

    cni = "cilium";

    disable = [
      "rke2-ingress-nginx"
    ];
  };

  # Don't interfere with k8s
  networking.firewall.enable = lib.mkForce false;
}
