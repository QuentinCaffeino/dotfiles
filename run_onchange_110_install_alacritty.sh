#!/usr/bin/env sh

set -ex

. $(chezmoi source-path)/utils/install.sh

_pre_install_alacritty() {
  echo "Installing nixgl, this is required for non-nix systems"
  nix-channel --add https://github.com/guibou/nixGL/archive/main.tar.gz nixgl && nix-channel --update
  nix-env -iA nixgl
}

_install_alacritty() {
  nix-env -iA nixpkgs.alacritty
}

_post_install_alacritty() {
  # alias alacritty='nixGLMesa alacritty'
  # create desktop file?
  return 0
}

main() {
  install alacritty "none" "none" "_pre_install_alacritty" "_install_alacritty" "_post_install_alacritty"
}

main "$@"
