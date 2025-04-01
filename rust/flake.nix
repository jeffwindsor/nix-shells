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
        name = "rust";
        
        packages = with pkgs; [
          cargo
          rustc
          rust-analyzer
          rustfmt
          clippy
        ];
        
      	shellHook = ''
          function cargo-new(){
            cargo new $@
            cd $@
            l
          }

          alias cn='cargo-new'
          alias cr='cargo run'
          alias ct='cargo test'
          alias cc='cargo check'
    
          echo -e "\e[1;94m == Development Environment =="
        	cargo --version
          rustc --version
          rust-analyzer --version
          rustfmt --version
          clippy --version
    		  echo -e "\e[0m"
    	  '';
      };
    }
  );
}
