#!/usr/bin/env sh

set -ex

. $(chezmoi source-path)/utils/is_installed.sh

_nix_package_installed() {
  printf $(nix-env --query alacritty &>/dev/null; printf $?)
}

# @params {string} $1 pkg name
# @params {string} $1 pkg manager
# @params {string} $2 pre hook
# @params {string} $3 installed hook
# @params {string} $4 pre-install hook
# @params {string} $5 install hook
# @params {string} $6 post-install hook
install() {
  local pkg_name="$1"
  local pre_hook="${2:-none}"
  local installed_hook="${3:-none}"
  local pre_install_hook="${4:-none}"
  local install_hook="${5:-none}"
  local post_install_hook="${6:-none}"

  if [ $pre_hook != "none" ];
  then
    echo "install:executing pre hook for $pkg_name"
    $pre_hook $pkg_name
  fi

  if [ $(is_installed $pkg_name) == '0' ];
  then
    echo "install:$pkg_name is already installed, skipping"

    if [ $installed_hook != "none" ];
    then
      echo "install:executing installed hook for $pkg_name"
      $installed_hook $pkg_name
    fi

    return 0
  fi

  echo "install:package:$pkg_name was not found"

  if [ $pre_install_hook != "none" ];
  then
    echo "install:executing pre-install hook for $pkg_name"
    $pre_install_hook $pkg_name
  fi

  echo "installing $pkg_name"
  if [ $install_hook != "none" ];
  then
    echo "install:executing install hook for $pkg_name"
    $install_hook $pkg_name
  fi

  if [ $post_install_hook != "none" ];
  then
    echo "install:executing post-install hook for $pkg_name"
    $post_install_hook $pkg_name
  fi
}
