{
  config,
  pkgs,
  ...
}:
{
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Virtualization
  # virtualisation.containers.enable = true;
  virtualisation.docker = {
    enable = true;
  };

  fileSystems =
    let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      secretPath = config.sops.secrets."wke/syncwke_secret".path;

      mountPoints = [
        "home"
        "Public"
        "EAS_RW"
      ];
    in
    builtins.listToAttrs (
      map (mountPoint: {
        name = "/mnt/syncwke/${mountPoint}";
        value = {
          device = "//syncwke.csie.ncnu.edu.tw/${mountPoint}";
          fsType = "cifs";
          options = [ "${automount_opts},credentials=${secretPath}" ];
        };
      }) mountPoints
    );

  sops.secrets."wke/syncwke_secret" = { };
}
