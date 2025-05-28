{ ... }:
{
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  # # DevOps Cloud
  # Host cloud-server
  #   Hostname 10.22.23.215
  #   User baas
  # Host cloud-worder-01
  #   Hostname 10.21.20.155
  #   User baas
  # Host cloud-worder-02
  #   Hostname 10.21.20.248
  #   User baas
  # Host cloud-worker-03
  #   Hostname 10.21.26.229
  #   User baas
  # Host cloud-lb (self)
  #   Hostname 10.21.20.191
  #   User baas
  services.nginx = {
    enable = true;

    streamConfig = ''
      upstream kube_web {
        server 10.22.23.215:30080;
        server 10.21.20.155:30080;
        server 10.21.20.248:30080;
        server 10.21.20.229:30080;
      }

      upstream kube_websecure {
        server 10.22.23.215:30443;
        server 10.21.20.155:30443;
        server 10.21.20.248:30443;
        server 10.21.20.229:30443;
      }

      server {
        listen 80;
        proxy_pass kube_web;
      }

      server {
        listen 443;
        proxy_pass kube_websecure;
      }
    '';
  };
}
