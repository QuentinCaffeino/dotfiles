#!/usr/bin/env sh

set -ex

. $(chezmoi source-path)/utils/install.sh

_install_nix() {
  # TODO
  # for readonly fs see https://christitus.com/steamdeck-as-a-desktop/
  # scripts detecting fs and if its readonly can be found in utils

  echo "installing nix..."
}

main() {
  install nix "none" "none" "none" "_install_nix"
}

main "$@"
