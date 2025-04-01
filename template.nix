{
  inputs = {
    # packages
    nixpkgs.url = "github:NixOS/nixpkgs/{package_version}";
    # helper functions
    utils.url = "github:numtide/flake-utils";
  };

  # build the same structure for each system
  #   default systems are ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"]
  outputs = { nixpkgs, utils, ... }: utils.lib.eachDefaultSystem (system:
    let
      # set pkgs for the given architecture, via the `system:` function arg
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # pkgs.mkShell is a specialized stdenv.mkDerivation that removes some
      # repetition when using it with nix-shell (or nix develop).
      devShell = pkgs.mkShell {
      	name = "{shell_name}";
        packages = with pkgs; [
          # list packages for the shell, here
        ];
        shellHook = ''
          echo -e "\e[1;94m == Development Shell for {shell_name} =="
          # add information useful to the user, like pkg --version calls.
          echo -e "\e[0m"
        '';
      };
    }
  );
}
