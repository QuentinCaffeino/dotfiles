#!/usr/bin/env sh

set -ex

# returns 0 if exists
# @params {string} $1 command-name
# @returns {int}
is_installed() {
  printf $(command -v $1 &>/dev/null; printf $?)
}
