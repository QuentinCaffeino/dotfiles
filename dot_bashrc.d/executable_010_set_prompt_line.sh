function set_prompt_line {
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local        BLUE="\[\033[0;34m\]"
  local  LIGHT_BLUE="\[\033[1;34m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  # END OPTIONAL
  local     DEFAULT="\[\033[0m\]"

  export PS1="${debian_chroot:+($debian_chroot)}$LIGHT_BLUE\W $LIGHT_RED\$(git_current_branch_name)$DEFAULT$ "

  unset acolor_prompt force_color_prompt
}

set_prompt_line
