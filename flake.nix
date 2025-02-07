{
  description = ''
    Flake for ZSH Config

    Dotfiles which store my ZSH setup without any framework (such as omz, while
    inspired from them).
    Bash support has been dropped lately.
  '';

  inputs = {
    nixpkgs = {
      url = "nixpkgs/nixos-unstable";
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
    formatter = forAllSystems (
      system:
        (pkgsForSystem system).alejandra
    );

    # PACKAGES
    # ========================================================================
    packages = forAllSystems (system: rec {
      zshrc = with (pkgsForSystem system);
        callPackage ./package.nix {};
      default = zshrc;
    });

    # HOME MANAGER MODULES
    # ========================================================================
    homeManagerModules = {
      shellrc = import ./modules/home-manager.nix self;
    };
    homeManagerModule = self.homeManagerModules.shellrc;

  };
}
