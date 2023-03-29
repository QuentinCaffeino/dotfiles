#!/usr/bin/env bash

set -ex

function main {
	local RC_FILENAME="bashrc"
	local RCD_PATH="~/.$RC_FILENAME.d"
	local RC_PATH="$HOME/.$RC_FILENAME"

	if ! pgrep -u "$USER" ssh-agent > /dev/null; then
		echo 'current bashrc does not autostart ssh-agent, appending...'
		cat >> "$RC_PATH" <<EOF

# ### Inserted by chezmoi ###
# User specific aliases and functions
if ! pgrep -u "\$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "\$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "\$SSH_AUTH_SOCK" ]]; then
    source "\$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

EOF
	fi
}

main "$@"
