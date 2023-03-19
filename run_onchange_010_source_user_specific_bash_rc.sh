#!/usr/bin/env bash

set -ex

function main {
	local RC_FILENAME="bashrc"
	local RCD_PATH="~/.$RC_FILENAME.d"
	local RC_PATH="$HOME/.$RC_FILENAME"

	if [[ $(grep -q ${RCD_PATH} ${RC_PATH}; printf $?) != 0 ]]; then
		echo 'current bashrc does not source user specific aliases and functions, appending...'
		cat >> "$RC_PATH" <<EOF

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "\$rc" ]; then
			. "\$rc"
		fi
	done
fi

unset rc

EOF
	fi
}

main "$@"
