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
        	name = "AWS";
        packages = with pkgs; [
awscli2
nodePackages.aws-cdk
];
          shellHook = ''
            echo -e "\e[1;94m == Development Environment =="
            # add --version or some other call to list dev packages
            echo -e "https://operations.cj.dev/"
            aws --version
            echo -e "\e[0m"
          '';
      };
    }
  );
}
