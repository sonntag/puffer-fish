{
  description = "Dev shell for testing puffer-fish";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
      pluginRepo = ./.; # assuming your fish plugin is the root
    in {
      devShells.default = pkgs.mkShell {
        packages = [pkgs.fish];

        shellHook = ''
          echo "Launching fish shell with plugin loaded..."
          export XDG_CONFIG_HOME=$PWD/dev-config

          mkdir -p $XDG_CONFIG_HOME/fish/functions
          mkdir -p $XDG_CONFIG_HOME/fish/conf.d

          # Symlink your plugin files into the fake fish config
          ln -sf ${pluginRepo}/functions/* $XDG_CONFIG_HOME/fish/functions/
          ln -sf ${pluginRepo}/conf.d/* $XDG_CONFIG_HOME/fish/conf.d/

          # Start fish as the dev shell
          exec ${pkgs.fish}/bin/fish
        '';
      };
    });
}
