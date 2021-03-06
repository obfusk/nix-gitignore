#!/usr/bin/env bash

set -euo pipefail

source="$(nix-build -E '(import ./test.nix {}).sourceUnfiltered')/test-tree"
rm -rf test-tree; cp --no-preserve=all -r "$source" .
trap 'rm -r test-tree result' EXIT

test=$(nix-build --no-out-link -E '(import ./test.nix { source = ./test-tree; }).success')

[ -e "$test/success" ] && echo -e '\e[1;32msuccess'
