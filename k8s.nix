{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
	name = "k8s";
	packages = with pkgs; [ k9s kustomize kubectl ];
  shellHook = ''
    echo -e "\e[1;33mDevelopment Environment\e[0;32m"
    # add --version or some other call to list dev packages
    k9s version
		kustomize version
		kubectl version
    echo -e "\e[0m"
    '';
}
