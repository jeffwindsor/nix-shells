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
      	name = "nix";
      	packages = with pkgs; [ nixd ];

        # shellHook (default: ""). Bash statements that are executed by nix-shell.
        shellHook = ''
          echo -e "\e[1;94m == Nix Development Environment =="
        	nixd --version
      		echo -e "\e[0m"

        '';
      };
    }
  );
}
