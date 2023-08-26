#!/bin/bash
SCRIPTDIR="$(dirname "$(readlink -f "$0")")"
SRCDIR="${SCRIPTDIR}/bashrc.d"
DSTDIR="${HOME}/.bashrc.d"

readonly SCRIPTDIR
readonly SRCDIR
readonly DSTDIR

mkdir -p "${DSTDIR}"

find "${SRCDIR}" -maxdepth 1 -mindepth 1 -type f -name '*.sh' | \
  while read -r target
  do
    install -m 644 "${target}" "${DSTDIR}"
  done
