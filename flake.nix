{
  description = ''
    Flake for ZSH Config

    Dotfiles which store my ZSH setup without any framework (such as omz, while
    inspired from them).
    Bash support has been dropped lately.
  '';

  inputs = {
    # Stable Nix Packages
    nixpkgs = {
      url = "nixpkgs/nixos-24.05";
      # url = "github:nixos/nixpkgs/nixos-unstable";
    };
    # Flake Utils Lib
    utils = {
      url = "github:numtide/flake-utils";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {self, ...}: let
    pkgsForSystem = system:
      import inputs.nixpkgs {
        inherit system;
      };
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = inputs.nixpkgs.lib.genAttrs allSystems;

    allSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  in {
    # TOOLING
    # ========================================================================
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (
      system:
        inputs.alejandra.defaultPackage.${system}
    );
    homeManagerModules = {
      shellrc = import ./modules/home-manager.nix self;
    };
    homeManagerModule = self.homeManagerModules.shellrc;

    # Exemple of package
    overlays.default = final: prev: {
      zshrc = final.callPackage ./package.nix {};
    };
    packages = forAllSystems (system: rec {
      zshrc = with import inputs.nixpkgs {inherit system;};
        callPackage ./package.nix {};
      default = zshrc;
    });
  };
}
