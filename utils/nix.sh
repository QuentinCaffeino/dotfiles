#!/usr/bin/env sh

set -ex

# @param {string} $1 package name
nix_is_package_installed() {
  printf $(nix-env --query $1 &>/dev/null; printf $?)
}

# @param {string} $1 command
nix() {
  local command=$1
  shift


}
