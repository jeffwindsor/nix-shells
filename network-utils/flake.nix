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
      	name = "network-utils";
      	packages = with pkgs; [
          bandwhich
          bottom
          
        ];
        shellHook = ''
          echo -e "\e[1;94m == Development Environment =="
          echo -e "\e[0m"
        '';
      };
    }
  );
}
