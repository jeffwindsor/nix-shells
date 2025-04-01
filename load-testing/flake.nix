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
        name = "Load-testing";
        packages = with pkgs; [
          vegeta   # Versatile HTTP load testing tool
          k6       # Modern load testing tool,
        ];
        
        shellHook = ''
          echo -e "\e[1;94m == Development Environment =="
          vegeta --version
          k6 --version
          echo -e "\e[0m"
        '';
      };
    }
  );
}
