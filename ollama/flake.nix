{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, utils, ... }: utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShell = pkgs.mkShell {
      	name = "ollama";
        packages = with pkgs; [
          ollama
        ];
        shellHook = ''
        	function ollama-select-run() {
        		local selection
        		selection=$(ollama list | tail -n +2 | cut -d':' -f1 | fzf)
        		[[ -n $selection ]] && ollama run $selection
        	}

          alias or="ollama-select-run"
          alias os="ollama serve"
          alias op="ollama ps"
        
          echo -e "\e[1;94m == ollama nix shell =="
          ollama --version
          echo -e "\e[0m"

          alias | grep "ollama"
          
        '';
      };
    }
  );
}
