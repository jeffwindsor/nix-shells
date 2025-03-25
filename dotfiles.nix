{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
	
	name = "dotfiles";
  	
    # packages (default: []). Add executable packages to the nix-shell environment.
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
  	echo -e "\e[1;33mDevelopment Environment for dotfiles\e[0;32m"
  	nixd --version
    taplo --version
    # shellcheck --version
    echo -e "bash-language-server $(bash-language-server --version)"
		echo -e "\e[0m"
  '';
}
