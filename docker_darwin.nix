{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  name = "docker on darwin";

  # packages (default: []). Add executable packages to the nix-shell environment.
  packages = with pkgs; [
    lima
    colima
    docker
    lazydocker
  ];

  # shellHook (default: ""). Bash statements that are executed by nix-shell.
  shellHook = ''
    echo -e "\e[1;33mDevelopment Environment\e[0;32m"

    # useful docker aliases
  	alias dcl='docker container ls --all'
  	alias dil='docker image ls'
  	alias dila='docker image ls --all'
  	alias dir='docker image rm -f'
  	alias dr='docker run -it '
    if command -v fzf &>/dev/null; then
      alias ds="docker stop $(docker ps --format \"\${FZF_DOCKER_PS_FORMAT}\" | fzf)"
    fi
    alias ld='lazydocker'

    # start colima to make docker available
    colima start

    # visual checks
    lima --version
    colima --version
    alias | rg docker
 
	  echo -e "\e[0m"
  '';
}
