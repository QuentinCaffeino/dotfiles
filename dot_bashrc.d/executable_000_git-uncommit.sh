git config --global alias.uncommit '!f() { git reset --soft "$(git log --format=%H -2 | tail -1)"; }; f'
