git config --global alias.pr '!f() { if [ $# -lt 1 ]; then
  echo "Usage: git pr <id> [<remote>] # assuming <remote>[=origin] is on GitHub";
  else git checkout -q "$(git rev-parse --verify HEAD)" &&
  git fetch -fv "${2:-origin}" pull/"$1"/head:pr/"$1" &&
  git checkout pr/"$1";
  fi; }; f'
