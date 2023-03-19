# Very stupid and naive way to extract repo path from input arguments
# works for `git`, `ssh` and `http` urls
function gc {
  # $@ = "asd https://github.com/quentincaffeino/godot-console.git  asd asd"
  REPO_FULL_NAME=$(echo "$@" | sed -rE "s@(git|ssh|https?)@\n\1@")
  # $REPO_FULL_NAME = "asd \nhttps://github.com/quentincaffeino/godot-console.git  asd asd"
  REPO_FULL_NAME=$(echo "${REPO_FULL_NAME}" | egrep "^(git|ssh|https?)")
  # $REPO_FULL_NAME = "https://github.com/quentincaffeino/godot-console.git  asd asd"
  REPO_FULL_NAME=$(echo "${REPO_FULL_NAME}" | sed -rE "s@^(git|ssh|https?)(\@|:\/\/)@@gm")
  # $REPO_FULL_NAME = "github.com/quentincaffeino/godot-console.git  asd asd"
  REPO_FULL_NAME=$(echo "${REPO_FULL_NAME}" | sed -r "s@[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)@\1@gm")
  # $REPO_FULL_NAME = "/quentincaffeino/godot-console.git  asd asd"
  REPO_FULL_NAME=$(echo "${REPO_FULL_NAME}" | cut -c2-)
  # $REPO_FULL_NAME = "quentincaffeino/godot-console.git  asd asd"
  REPO_FULL_NAME=$(echo "${REPO_FULL_NAME}" | sed -rE "s@.git.*@@gm")
  # $REPO_FULL_NAME = "quentincaffeino/godot-console"

  if [ ! -d "$PWD/$REPO_FULL_NAME" ]; then
    echo "+ git clone $@ ${REPO_FULL_NAME}"
    git clone "$@" "${REPO_FULL_NAME}"
  fi

  echo "+ cd ${REPO_FULL_NAME}"
  cd "${REPO_FULL_NAME}"
}
