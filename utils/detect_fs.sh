#!/usr/bin/env sh

set -ex

# NOTE: was not tested

# returns root filesystem name ie brtfs or ext4
# @returns {string}
detect_fs() {
  printf $(findmnt -fn --output FSTYPE /)
}
