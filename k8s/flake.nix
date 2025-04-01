{
  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  outputs = { self, nixpkgs, utils }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShell = pkgs.mkShell {
      	name = "k8s";
      	packages = with pkgs; [
          k9s
          kustomize
          kubectl
        ];
        shellHook = ''
          echo -e "\e[1;94m == Development Environment =="
          # add --version or some other call to list dev packages
          k9s version
      		kustomize version
      		kubectl version
          echo -e "\e[0m"
        '';
      };
    }
  );
}
