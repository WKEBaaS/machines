{
  pkgs,
  config,
  ...
}:
let
  keycloak = "keycloak";
  keycloakPort = 30080;
  minioPort = 9000;
  minioConsolePort = 9001;
in
{
  environment.systemPackages = with pkgs; [
    minio-client
  ];
  services = {
    nginx = {
      enable = true;
      recommendedGzipSettings = true;

      virtualHosts."auth.wke.csie.ncnu.edu.tw" = {
        sslCertificateKey = config.sops.secrets."wke/ssl/key".path;
        sslCertificate = config.sops.secrets."wke/ssl/cert".path;
        sslTrustedCertificate = config.sops.secrets."wke/ssl/ca".path;
        forceSSL = true;
        locations."/" = {
          recommendedProxySettings = true;
          proxyPass = "http://localhost:${toString keycloakPort}/";
        };
      };

      virtualHosts."s3.wke.csie.ncnu.edu.tw" = {
        sslCertificateKey = config.sops.secrets."wke/ssl/key".path;
        sslCertificate = config.sops.secrets."wke/ssl/cert".path;
        sslTrustedCertificate = config.sops.secrets."wke/ssl/ca".path;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://localhost:${toString minioPort}";
          extraConfig = ''
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;

            proxy_connect_timeout 300;
            # Default is HTTP/1, keepalive is only enabled in HTTP/1.1
            proxy_http_version 1.1;
            proxy_set_header Connection "";
            chunked_transfer_encoding off;
          '';
        };
        locations."/minio/ui" = {
          proxyPass = "http://localhost:${toString minioConsolePort}";
          extraConfig = ''
            rewrite ^/minio/ui/(.*) /$1 break;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
            proxy_set_header X-NginX-Proxy true;

            # This is necessary to pass the correct IP to be hashed
            real_ip_header X-Real-IP;

            proxy_connect_timeout 300;

            # To support websockets in MinIO versions released after January 2023
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
            # Some environments may encounter CORS errors (Kubernetes + Nginx Ingress)
            # Uncomment the following line to set the Origin request to an empty string
            # proxy_set_header Origin '''''';

            chunked_transfer_encoding off;
          '';
        };
      };
    };

    minio = {
      enable = true;
      rootCredentialsFile = config.sops.secrets."lab/minio/credentials".path;
      consoleAddress = ":9000";
      listenAddress = ":9001";
      region = "tw-1";
    };

    keycloak = {
      enable = true;
      database = {
        type = "postgresql";
        createLocally = false;
        name = keycloak;
        username = keycloak;
        passwordFile = config.sops.secrets."lab/keycloak/database/password".path;
      };
      settings = {
        http-relative-path = "/";
        hostname = "auth.wke.csie.ncnu.edu.tw";
        http-port = keycloakPort;
        http-enabled = true;
        proxy-headers = "xforwarded";
      };
      initialAdminPassword = "keycloakadmin";
    };

    postgresql = {
      enable = true;
      authentication = ''
        #type database  DBuser  auth-method
        local all all trust
      '';
      ensureDatabases = [
        keycloak
        "hasura"
      ];
      ensureUsers = [
        {
          name = keycloak;
          ensureDBOwnership = true;
        }
        {
          name = "hasura";
          ensureDBOwnership = true;
        }
      ];
      initialScript = config.sops.templates."postgres-init.sql".path;
    };
  };

  sops.secrets = {
    "lab/minio/credentials" = {
      neededForUsers = true;
      owner = "minio";
    };
    "lab/keycloak/database/password" = { };
    "lab/postgres/password" = { };
    "wke/ssl/key".owner = "nginx";
    "wke/ssl/cert".owner = "nginx";
    "wke/ssl/ca".owner = "nginx";
  };

  sops.templates = {
    "postgres-init.sql" = {
      owner = "postgres";
      content = ''
        alter user postgres with password '${config.sops.placeholder."lab/postgres/password"}';
        alter user ${keycloak} with password '${config.sops.placeholder."lab/keycloak/database/password"}';
      '';
    };
  };
}
