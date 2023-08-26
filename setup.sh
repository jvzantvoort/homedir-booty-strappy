#!/bin/bash

C_SCRIPTPATH="$(readlink -f "$0")"
C_SCRIPTDIR="$(dirname "${C_SCRIPTPATH}")"
C_LIBEXEC="${C_SCRIPTDIR}/libexec.d"

readonly C_SCRIPTPATH
readonly C_SCRIPTDIR
readonly C_LIBEXEC

source "${C_SCRIPTDIR}/functions.sh"

function pathmunge()
{
    [[ -d "$1" ]] || return
    echo "$PATH" | grep -E -q "(^|:)$1($|:)" && return
    [[ "$2" == "after" ]] && PATH=$PATH:$1 || PATH=$1:$PATH
}

function list_libexec()
{
    find "${C_LIBEXEC}" -maxdepth 1 -mindepth 1 -type f -executable | sort
}

#------------------------------------------------------------------------------#
#                                    Main                                      #
#------------------------------------------------------------------------------#

# setup path
#---------------------------------------
pathmunge "${C_SCRIPTDIR}/bin"
export PATH

must_have_command "jq"

mkstaging_area

export STAGING_AREA

list_libexec | while read -r scriptpath
do
    printf "=>> %s\n" "$(basename "${scriptpath}")"
    $scriptpath
done

rmstaging_area

#------------------------------------------------------------------------------#
#                                  The End                                     #
#------------------------------------------------------------------------------#
