{
  isDarwin,
  username,
  ...
}:
{
  getDotfilePath =
    c:
    let
      basePath = if isDarwin then "/Users/" else "/home/";
    in
    basePath + username + "/.config/nix/home/dotfiles/" + c;

}
