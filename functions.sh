#!/bin/bash
#===============================================================================
#
#         FILE:  functions.sh
#
#        USAGE:  functions.sh
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

function gh_download_url()
{
  local repo="$1"
  local pattern="$2"

  curl -s https://api.github.com/repos/${repo}/releases/latest | \
    jq -M .assets[].browser_download_url | grep "${pattern}" | sed 's,\",,g'
}

function gh_download()
{
  local repo
  local pattern
  local url
  local downloaddir

  repo="$1"
  pattern="$2"
  downloaddir="$3"

  url="$(gh_download_url "${repo}" "${pattern}")"
  downloadfile="$(basename "${url}")"

  curl -LSso "${downloaddir}/${downloadfile}" "${url}"
  echo "${downloadfile}" > "${downloaddir}/lastdownload.lst"
}

function lastdownload()
{
    cat "${STAGING_AREA}/lastdownload.lst"
}

function mkstaging_area()
# ------------------------------------------------------------------------------
#         NAME:  mkstaging_area
#  DESCRIPTION:  Creates a temporary staging area and set the variable
#                $STAGING_AREA to point to it
#   PARAMETERS:  STRING, mktemp template (optional)
#      RETURNS:  0, oke
#                1, not oke
# ------------------------------------------------------------------------------
{
  [[ -n "${STAGING_AREA}" ]] && return

  local template
  local retv


  template="/tmp/homedir-booty-strappy.XXXXXXXX"

  STAGING_AREA="$(mktemp -d ${template})"
  retv="$?"
  return "${retv}"

} # end: mkstaging_area

function rmstaging_area()
{
  [[ -z "${STAGING_AREA}" ]] && return 0
  rm -rvf "${STAGING_AREA}" || return 1
}




#------------------------------------------------------------------------------#
#                                  The End                                     #
#------------------------------------------------------------------------------#
