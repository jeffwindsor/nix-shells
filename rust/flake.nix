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
          alias cr='clear && cargo run'
          alias ct='clear && cargo test'
          alias cc='clear && cargo check'
    
          echo -e "\e[1;94m == Rust Development Environment =="
        	cargo --version
          rustc --version
          rust-analyzer --version
          rustfmt --version
          cargo clippy --version

          # print out aliases
          alias | rg "cargo"
    		  echo -e "\e[0m"

          # open dotfiles in editor
          "$EDITOR" "$DOTFILES"
    	  '';
      };
    }
  );
}
