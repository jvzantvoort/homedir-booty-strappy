#!/bin/bash
C_SCRIPTPATH="$(readlink -f "$0")"
C_SCRIPTDIR="$(dirname "${C_SCRIPTPATH}")"
C_TOPDIR="$(dirname "${C_SCRIPTDIR}")"

readonly C_SCRIPTPATH
readonly C_SCRIPTDIR
readonly C_TOPDIR

source "${C_TOPDIR}/functions.sh"

mkdir -p "${HOME}/bin"
gh_download google/yamlfmt Linux_x86_64 "${STAGING_AREA}"
pushd "${STAGING_AREA}"
tar -zxvf "$(lastdownload)"
install -m 755 yamlfmt "${HOME}/bin/yamlfmt"
popd
