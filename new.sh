#!/usr/bin/env bash

shell_name="$1"
package_version="${2:-nixpkgs-unstable}"
path="$(dirname "$0")/$shell_name"

# create sub directory
mkdir -p "$path"

# read template.nix
# 1. replace placeholders with values
# 2. remove all comment lines
# 3. put result in the new directory as flake.nix
cat template.nix | sed \
 -e "s/{shell_name}/$shell_name/g" \
 -e "s/{package_version}/$package_version/g" \
 -e '/^ *#/d' \
> "$path/flake.nix"
