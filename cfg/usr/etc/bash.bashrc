# Customize bash

main() {
  if [[ -o interactive && -z "${BASHRC_USED}" ]]; then
    BASHRC_USED='true'
    set +o history
  fi
}

main
