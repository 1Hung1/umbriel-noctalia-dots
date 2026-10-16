{ pkgs, ... }:

{
  # Declarative Git configuration
  programs.git = {
    enable = true;
    settings.user.name = "Hung"; # set your github username here
    settings.user.email = "legiahung.ny@gmail.com"; # set your email here
    settings.init.defaultBranch = "main";
  };
}
