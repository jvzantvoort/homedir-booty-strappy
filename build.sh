#!/bin/bash
#===============================================================================
#
#         FILE:  build.sh
#
#        USAGE:  build.sh
#
#  DESCRIPTION:  Bash script
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  jvzantvoort (John van Zantvoort), john@vanzantvoort.org
#      COMPANY:  JDC
#      CREATED:  2023-08-26
#
# Copyright (C) 2023 John van Zantvoort
#
#===============================================================================
C_SCRIPTPATH="$(readlink -f "$0")"
C_SCRIPTNAME="$(basename "$C_SCRIPTPATH" .sh)"
C_FACILITY="local0"
C_SCRIPTDIR="$(dirname "${C_SCRIPTPATH}")"

readonly C_SCRIPTPATH
readonly C_SCRIPTNAME
readonly C_FACILITY
readonly C_SCRIPTDIR

source "${C_SCRIPTDIR}/functions.sh"


function build_bash_package()
{
    local outputfile
    local payloaddir
    local basedir
    outputfile="${1}"
    payloaddir="${C_SCRIPTDIR}/payload"
    basedir="${payloaddir}/bash"
    pushd "${payloaddir}" >/dev/null 2>&1 || die "chdir: ${payloaddir}"
    makeself bash "${outputfile}" "bashsetup" "./main.sh" --gzip --nox11 --nowait
    popd >/dev/null 2>&1 || die "chdir: olddir"

}
#------------------------------------------------------------------------------#
#                                    Main                                      #
#------------------------------------------------------------------------------#

build_bash_package "bashsetup.bin"

#------------------------------------------------------------------------------#
#                                  The End                                     #
#------------------------------------------------------------------------------#
