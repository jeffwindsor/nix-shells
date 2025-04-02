{
  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  outputs = { nixpkgs, utils, ... }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShell = pkgs.mkShell {
      	name = "dotfiles";
      	packages = with pkgs; [
          # Nix
          nixd

          # Shell
          bash-language-server
          shellcheck
          shfmt

          # TOML
          taplo

          # YAML
          yaml-language-server
      	];

        # shellHook (default: ""). Bash statements that are executed by nix-shell.
        shellHook = ''
          echo -e "\e[1;94m == Nix/Toml/Bash Development Environment =="
        	nixd --version
          taplo --version
          # shellcheck --version
          echo -e "bash-language-server $(bash-language-server --version)"
      		echo -e "\e[0m"

          # open dotfiles in editor
          "$EDITOR" "$DOTFILES"
        '';
      };
    }
  );
}
