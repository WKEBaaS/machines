{
  config,
  username,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [
    gcc
  ];

  users.mutableUsers = false;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    home = "/home/${username}";
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    hashedPasswordFile = config.sops.secrets."personal/password".path;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJGr7f6G1KLjfEvevz1Xc1jiLcalf/FqofnwNDP4587W youmin@MacBook-Air"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPmm9xWkhK9Oxt+z24eHTeWQGqhvc6O757RMUMjC8VNv youmin@nixos-lab"
    ];
  };

  security.sudo.extraRules = [
    {
      users = [ username ];
      commands = [
        {
          command = "ALL";
          options = [
            "NOPASSWD"
          ];
        }
      ];
    }
  ];

  sops.secrets = {
    "personal/password" = {
      neededForUsers = true;
    };
  };
}
