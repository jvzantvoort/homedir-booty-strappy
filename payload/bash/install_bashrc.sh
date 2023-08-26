#!/bin/bash
SCRIPTDIR="$(dirname "$(readlink -f "$0")")"
NOW="$(date +%y%m%d)"
SOURCEFILE="${SCRIPTDIR}/bashrc"

readonly SCRIPTDIR
readonly NOW
readonly SOURCEFILE

[[ -f "${HOME}/.bashrc.${NOW}" ]] || cp -v "${HOME}/.bashrc" "${HOME}/.bashrc.${NOW}"

[[ -f "${SOURCEFILE}" ]] && cat "${SOURCEFILE}" > "${HOME}/.bashrc"
