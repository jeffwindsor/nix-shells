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
      	name = "python 3.12";
        
      	packages = with pkgs; [
          (python312.withPackages(p: with p; [ python-lsp-server black pytest ]))

          # for scripts
          bash-language-server
          shellcheck
          shfmt
      	];

       	shellHook = ''
          echo -e "\e[1;94m == Python Development Environment =="
          python --version
          pylsp --version
          pytest --version
          echo -e "\e[0m"
      	'';
      };
    }
  );
}
