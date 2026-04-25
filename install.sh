#!/system/bin/env sh
# SPDX-License-Identifier: 0BSD
# Setup environment
set -e

install_bootstrap() {
  local bootstrap="${HOME}/bootstrap"
  [ -d "${bootstrap}" ] && rm -rf -- "${bootstrap}"
  mkdir -p -- "${bootstrap}"
  local arch
  arch="$(uname -m)"
  if [ "${arch}" == 'aarch64' ]; then
    local url_arch='aarch64'
  else
    local url_arch='arm'
  fi
  local zip_url
  zip_url='https://github.com/termux-pacman/termux-packages/releases/latest'
  zip_url="${zip_url}/download/bootstrap-${url_arch}.zip"
  "${PREFIX}/bin/curl" -fLZ -o "${PREFIX}/bootstrap.zip" "${zip_url}"
  "${PREFIX}/bin/unzip" -d "${bootstrap}" "${PREFIX}/bootstrap.zip"
  cd "${bootstrap}"
  "${PREFIX}/bin/awk" -F '←' '{system("ln -sv '"'"'"$1"'"'"' '"'"'"$2"'"'"' &")}' \
    "${bootstrap}/SYMLINKS.txt"
  rm -f -- "${bootstrap}/SYMLINKS.txt"
  rm -rf -- "${PREFIX}"
  cd ..
  mv -v -- "${bootstrap}" "${PREFIX}"
  export PATH="${PREFIX}/bin"
  rm -rf -- "${PREFIX}/etc/termux"
  mkdir -p -- "${HOME}/shizuku"
  echo > "${PREFIX}/etc/motd"
}

customize() {
  [[ ! -d "${HOME}/storage" ]] && termux-setup-storage
  local tmp="${PREFIX}/tmp/tqs"
  [ -d "${tmp}" ] && rm -rf -- "${tmp}"
  mkdir -p -- "${tmp}"
  local rel_url rel_url='https://github.com/nedorazrab0/tqs/releases/download/tqs'
  rel_url="${rel_url}/tqs.zip"
  local rel_path="${tmp}/tqs.zip"
  curl -fL -o "${rel_path}" "${rel_url}"
  unzip -d "${tmp}" "${rel_path}"
  bash "${tmp}/customize.sh"
}

main() {
  if [ -n "${TERMUX_MAIN_PACKAGE_FORMAT}" ]; then
    echo 'Not failsafe' >&2
    exit 1
  fi
  install_bootstrap
  customize
}

main
