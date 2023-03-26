__steamos_prompt_command() {
  # could not find other way to override PS1 on steamos, this method is called
  # from somewhere after everything else
  return 0
}

_git_current_branch_name() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}

set_prompt_line() {
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local        BLUE="\[\033[0;34m\]"
  local  LIGHT_BLUE="\[\033[1;34m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  local     DEFAULT="\[\033[0m\]"

  export PS1="$LIGHT_BLUE\W $LIGHT_RED\$(_git_current_branch_name)$DEFAULT$ "

  unset acolor_prompt force_color_prompt
}

set_prompt_line
