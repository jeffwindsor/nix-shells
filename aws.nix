{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
	name = "AWS";
	packages = with pkgs; [ awscli2 ];
  shellHook = ''
    echo -e "\e[1;33mDevelopment Environment\e[0;32m"
    # add --version or some other call to list dev packages
    echo -e "https://operations.cj.dev/"
    aws --version
    echo -e "\e[0m"
    '';
}
