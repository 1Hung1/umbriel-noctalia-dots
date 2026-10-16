# Setting up this repo's dots on NixOS with flakes and home manager

First thing first, change/add your current flake.nix to have:
```
{
  nixConfig = {
    extra-experimental-features = [ "flakes" "nix-command" "pipe-operators" ]; # add this or change the values if you already have this
  };

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    umbriel.url = "github:noctalia-dev/umbriel/cachix";
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
    # all of your other flakes go here
  };
  outputs = { self, nixpkgs, home-manager, ...}@inputs: {
    nixosConfigurations =  {
      # you can change the config name to anything if you want
      nixos-btw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux"; # change this to your system
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix

          # Add home-manager as a NixOS module
          home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
```
- Add/change this on your home manager file as well:
```
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    google-chrome # my web broswer, can change if needed
    fastfetch
    alacritty # the terminal
    qt6Packages.qt6ct
    nerd-fonts.jetbrains-mono # my font
  ];

  # Import my settings and configs
  imports = [
  	./homemanager
  ];
}
```
- Add/change this on your configuration.nix as well:
```
{ inputs, config, pkgs, ... }:

{
  users.users."username-here" = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users."username-here" = import ./your-homemanager-file-here.nix;
  };

  environment.systemPackages = with pkgs; [
     micro
     wget
     curl
     zsh
  ];

  # Enable my shell and umbriel and noctalia
  programs.zsh.enable = true;
  programs.umbriel.enable = true;
  programs.noctalia.enable = true;
```
Then make a homemanager folder with the same contents of this github repo's homemanager folder, rebuild and reboot
