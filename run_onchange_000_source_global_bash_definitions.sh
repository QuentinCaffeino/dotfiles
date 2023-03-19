#!/usr/bin/env bash

set -ex

function main {
	local RC_FILENAME="bashrc"
	local GLOBAL_RC_PATH="/etc/$RC_FILENAME"
	local RC_PATH="$HOME/.$RC_FILENAME"

	local TMP_PATH="/tmp/chezmoi-apply"
	if [ ! -e "$TMP_PATH" ]; then
		mkdir -p "$TMP_PATH"
	fi
	local TMP_RC_PATH="$TMP_PATH/$RC_FILENAME"

	if [[ $(grep -q ${GLOBAL_RC_PATH} ${RC_PATH}; printf $?) != 0 ]]; then
		echo 'current bashrc does not source global definitions, prepending...'
		cp "$RC_PATH" "$TMP_RC_PATH"

		cat > "$RC_PATH" <<EOF
# Source global definitions
if [ -f $GLOBAL_RC_PATH ]; then
	. $GLOBAL_RC_PATH
fi
EOF

		cat "$TMP_RC_PATH" >> "$RC_PATH"
	fi
}

main "$@"
