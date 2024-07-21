# BEGIN DOTGIT-SYNC BLOCK MANAGED
self: {
  pkgs,
  lib,
  config,
  # BEGIN DOTGIT-SYNC BLOCK EXCLUDED NIX_HOME_MANAGER_MODULE_CUSTOM
  ...
}: let
  cfg = config.zshrc;
in
{
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
    home ={
      file = {
        ".profile" ={
          text = "source '${self.packages.${pkgs.stdenv.hostPlatform.system}.default}/profile'";
        };
      };
    };
  };
  # END DOTGIT-SYNC BLOCK EXCLUDED NIX_HOME_MANAGER_MODULE_CUSTOM
}
# END DOTGIT-SYNC BLOCK MANAGED
