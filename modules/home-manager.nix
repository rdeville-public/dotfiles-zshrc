self: {
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.zshrc;
in {
  options = {
    zshrc = {
      enable = lib.mkEnableOption "Activate ZSH module to install dotfiles";
    };
  };

  config = lib.mkIf cfg.enable {
    xdg = {
      configFile = {
        zsh = {
          source = lib.mkDefault self.packages.${pkgs.stdenv.hostPlatform.system}.default;
        };
      };
    };
  };
}
