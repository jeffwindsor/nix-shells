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
        name = "docker";

        packages = with pkgs; [
          lima  # Linux virtual machines (on macOS, in most cases)
          colima  # Container runtimes with minimal setup
          docker  # Open source project to pack, ship and run any application as a lightweight container
          lazydocker  # Simple terminal UI for both docker and docker-compose
          dive  # Tool for exploring each layer in a docker image
          ctop  # Top-like interface for container metrics
        ];

        # Bash statements that are executed by nix-shell.
        shellHook = ''
          echo -e "\e[1;94m == Development Environment =="

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
      };
    }
  );
}
