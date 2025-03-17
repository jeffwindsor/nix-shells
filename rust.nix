{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
    name = "rust";
	# https://search.nixos.org/packages?channel=unstable
    packages = with pkgs; [
      cargo
      rustc
      rust-analyzer
      rustfmt
      clippy
    ];
  	shellHook = ''

      # helpers
      function cargo-new(){
        cargo new $@
        cd $@
        l
      }

      alias cn='cargo-new'
      alias cr='cargo run'
      alias ct='cargo test'
      alias cc='cargo check'
      
      
      # check env
    	echo -e "\e[1;33m== Rust Development Shell ==\e[0;32m"
    	cargo --version
      rustc --version
      rust-analyzer --version
      rustfmt --version
      clippy --version
		  echo -e "\e[0m"
  	  '';
}
