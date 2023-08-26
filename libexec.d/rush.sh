#!/bin/bash
C_SCRIPTPATH="$(readlink -f "$0")"
C_SCRIPTDIR="$(dirname "${C_SCRIPTPATH}")"
C_TOPDIR="$(dirname "${C_SCRIPTDIR}")"

readonly C_SCRIPTPATH
readonly C_SCRIPTDIR
readonly C_TOPDIR

source "${C_TOPDIR}/functions.sh"

mkdir -p "${HOME}/bin"
gh_download shenwei356/rush linux_amd64 "${STAGING_AREA}"
pushd "${STAGING_AREA}"
tar -zxf "$(lastdownload)"
install -m 755 rush "${HOME}/bin/rush"
popd
