#!/bin/bash
C_SCRIPTPATH="$(readlink -f "$0")"
C_SCRIPTDIR="$(dirname "${C_SCRIPTPATH}")"
C_TOPDIR="$(dirname "${C_SCRIPTDIR}")"

readonly C_SCRIPTPATH
readonly C_SCRIPTDIR
readonly C_TOPDIR

source "${C_TOPDIR}/functions.sh"

mkdir -p "${HOME}/bin"

find "${C_TOPDIR}/payload/bin" -type f | while read -r target
do
  printf "Install: %s\n" "$(basename "${target}")"
  install -m 755 "${target}" "${HOME}/bin"
done
