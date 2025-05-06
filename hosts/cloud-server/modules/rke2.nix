{ ... }:
{
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

  networking.firewall.allowedTCPPorts = [
    6443
    9345
    10250
    # etcd ports
    2379
    2380
    2381
    # Cilium ports
    4240
    8472
  ];
  networking.firewall.allowedUDPPorts = [ 8472 ];
}
