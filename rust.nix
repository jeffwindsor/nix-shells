{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
    name = "rust";
	# https://search.nixos.org/packages?channel=unstable
    packages = with pkgs; [ cargo rustc ];
  	shellHook = ''
    	echo -e "\e[1;33mDevelopment Environment\e[0;32m"
    	# add --version or some other call to list dev packages
    	cargo --version
      rustc --version
		  echo -e "\e[0m"
  	  '';
}
