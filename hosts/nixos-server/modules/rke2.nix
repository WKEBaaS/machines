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
  };

  networking.firewall.allowedTCPPorts = [
    6443
    9345
    # etcd ports
    2379
    2380
    2381
  ];
}
