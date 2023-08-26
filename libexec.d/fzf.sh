#!/bin/bash
C_SCRIPTPATH="$(readlink -f "$0")"
C_SCRIPTDIR="$(dirname "${C_SCRIPTPATH}")"
C_TOPDIR="$(dirname "${C_SCRIPTDIR}")"

readonly C_SCRIPTPATH
readonly C_SCRIPTDIR
readonly C_TOPDIR

source "${C_TOPDIR}/functions.sh"

mkdir -p "${HOME}/bin"
gh_download junegunn/fzf linux_amd64 "${STAGING_AREA}"
pushd "${STAGING_AREA}"
tar -zxf "$(lastdownload)"
install -m 755 fzf "${HOME}/bin/fzf"
popd

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
