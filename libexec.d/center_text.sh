#!/bin/bash
C_SCRIPTPATH="$(readlink -f "$0")"
C_SCRIPTDIR="$(dirname "${C_SCRIPTPATH}")"
C_TOPDIR="$(dirname "${C_SCRIPTDIR}")"

readonly C_SCRIPTPATH
readonly C_SCRIPTDIR
readonly C_TOPDIR

source "${C_TOPDIR}/functions.sh"

mkdir -p "${HOME}/bin"
gh_download jvzantvoort/center_text linux_amd64 "${STAGING_AREA}"
pushd "${STAGING_AREA}"
unzip "$(lastdownload)"
install -m 755 center_text "${HOME}/bin/center_text"
popd
