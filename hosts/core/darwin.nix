{ username, inputs, ... }:
{
  imports = [
    inputs.sops-nix.darwinModules.sops
  ];

  users.users.${username}.home = "/Users/${username}";
}
