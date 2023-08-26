#!/bin/bash
C_SCRIPTPATH="$(readlink -f "$0")"
C_SCRIPTDIR="$(dirname "${C_SCRIPTPATH}")"
C_TOPDIR="$(dirname "${C_SCRIPTDIR}")"

readonly C_SCRIPTPATH
readonly C_SCRIPTDIR
readonly C_TOPDIR

source "${C_TOPDIR}/functions.sh"

mkdir -p "${HOME}/bin"

find "${C_TOPDIR}/payload/bin" -type f -exec install -m 755 {} "${HOME}/bin" \;
